from web.db import SQLLiteral
import os

__author__ = 'Andrei'

import web
from xml.dom import minidom
import models
import appconfig

cfg = appconfig.Config()
db = web.database(dbn='postgres', user=cfg.db_user, pw=cfg.db_pw, db=cfg.db_db)

class Manager:
    def getPlants(self):
        xml = minidom.Document()
        herbarium = xml.createElement('herbarium')
        xml.appendChild(herbarium)
        plants = db.select('plants')
        for plt in plants:
            plant = xml.createElement(plt.name)
            plant.setAttribute('id', str(plt.plant_id))
            herbarium.appendChild(plant)

        return xml

    def checkBounds(self, x, y):
        if int(x) > cfg.field_x or int(x) < 0 or int(y) > cfg.field_y or int(y) < 0:
            return False
        else:
            return True

    def getPlantById(self, id):
        _plant = db.select(['field', 'plants', 'states'],
                           what="field.id, field.x, field.y, plants.plant_id, plants.name, states.state_id",
                           where="field.plant_id=plants.plant_id AND field.state_id=states.state_id AND field.id=$fid",
                           vars=dict(fid=id))
        if len(_plant) == 0:
            return None
        for pnt in _plant:
            p = models.Plant(pnt.id, pnt.plant_id, pnt.x, pnt.y, pnt.name, pnt.state_id)
            return p

    def getPlantByPlantId(self,id):
        _plant = db.select(['plants'],
                           where="plant_id=$pid",
                           vars=dict(pid=id))
        if len(_plant) == 0:
            return None
        for pnt in _plant:
            p = models.Plant(plant_id=pnt.plant_id, name=pnt.name)
            return p

    def getPlantByCoords(self, x, y):
        if not self.checkBounds(x, y):
            return False
        _plant = db.select(['field', 'plants', 'states'],
                           what="field.id, field.x, field.y, plants.plant_id, plants.name, states.state_id",
                           where="field.plant_id=plants.plant_id AND field.state_id=states.state_id AND field.x=$x AND field.y=$y"
                           , vars=dict(x=x, y=y))
        if len(_plant) == 0:
            return None
        for pnt in _plant:
            p = models.Plant(pnt.id, pnt.plant_id, pnt.x, pnt.y, pnt.name, pnt.state_id)
            return p

    def getField(self):
        xml = minidom.Document()
        country = xml.createElement("country")
        xml.appendChild(country)
        field = xml.createElement("field")
        field.setAttribute('zero_x', '0')
        field.setAttribute('zero_y', '0')
        field.setAttribute('size_x', cfg.field_x)
        field.setAttribute('size_y', cfg.field_y)
        country.appendChild(field)

        field_data = db.select(['field', 'plants', 'states'],
                               what="field.id, field.x, field.y, plants.plant_id, plants.name, states.state_id",
                               where="field.plant_id=plants.plant_id AND field.state_id=states.state_id")
        for tile in field_data:
            plant = xml.createElement(tile.name)
            plant.setAttribute('id', str(tile.id))
            plant.setAttribute('x', str(tile.x))
            plant.setAttribute('y', str(tile.y))
            plant.setAttribute('state', str(tile.state_id))
            field.appendChild(plant)

        return xml

    def getStateIdForPlant(self, plant_id, type, state_id=None):
        ids = []
        if type == "seed":
            ids = db.select('plant_states', what="state_id", where="level=$level AND plant_id=$pid",
                            vars=dict(pid=plant_id, level=SQLLiteral("(SELECT MIN(level) from plant_states)")))
        elif type == "grown":
            ids = db.select('plant_states', what="state_id", where="level=$level AND plant_id=$pid",
                            vars=dict(pid=plant_id, level=SQLLiteral("(SELECT MAX(level) from plant_states)")))
        elif type == "next":
            if not state_id:
                return False
            ids = db.select('plant_states', what="state_id", where="level=$level AND plant_id=$pid",
                            vars=dict(pid=plant_id, level=SQLLiteral(
                                    "(SELECT level+1 from plant_states WHERE state_id=" + str(
                                            state_id) + " AND plant_id=" + str(plant_id) + ")")))
        for _id in ids:
            return _id.state_id


    def seedPlant(self, x, y, plant_id):
        if not self.checkBounds(x, y):
            return False
        seedStateId = self.getStateIdForPlant(plant_id, 'seed')
        try:
            db.insert('field', x=x, y=y, plant_id=plant_id, state_id=seedStateId)
        except:
            return False

        return True

    def digPlant(self, x, y):
        if not self.checkBounds(x, y):
            return False
        elif not x and not y:
            return False
        elif not y:
            plantToDig = self.getPlantById(x) # first param only means field.id
        else:
            plantToDig = self.getPlantByCoords(x, y) # coords are sent

        if not plantToDig:  # no such plant
            return False

        if plantToDig.state_id == self.getStateIdForPlant(plantToDig.plant_id,
                                                          'grown'): #plant grown up and can be digged
            db.delete('field', where="id=$id", vars=dict(id=plantToDig.id))
            return True
        else:   #plant is not yet grown up. return error message
            return False

    def updateField(self):
        field_data = db.select(['field', 'plants', 'states'],
                               what="field.id, field.x, field.y, plants.plant_id, plants.name, states.state_id",
                               where="field.plant_id=plants.plant_id AND field.state_id=states.state_id")
        for tile in field_data:
            if tile.state_id < self.getStateIdForPlant(tile.plant_id, "grown"):
                db.update('field', where="id=$id",
                          state_id=self.getStateIdForPlant(tile.plant_id, "next", tile.state_id), vars=dict(id=tile.id))


    def getPlantImage(self,plant_id,state_id=None):

         if not state_id:
            state_id = self.getStateIdForPlant(plant_id, "seed")

         plant = self.getPlantByPlantId(plant_id)

         if not plant:
             return None,None

         pss = db.select(['plant_states'],
                               where="plant_id=$pid AND state_id=$sid",
                               vars = dict(pid = plant_id,sid = state_id))

         for ps in pss:
            sprite_name = ps.sprite_name

         sprite = os.path.abspath(os.path.join(cfg.res_dir,plant.name,"Images",sprite_name))
         return sprite, open(sprite,"rb").read()

    def getBackgroundImage(self):
        sprite = os.path.abspath(os.path.join(cfg.res_dir,cfg.background))
        return sprite, open(sprite,"rb").read()

