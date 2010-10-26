import models
import os

__author__ = 'Andrei'

from manager import Manager

import web

class BaseView(object):
    def __init__(self):
        self.broker = Manager()

class init(BaseView):
    def GET(self):

        return "Hello,World!"

class state(BaseView):
    def GET(self):
        return self.broker.getField().toxml()

class seed(BaseView):
    def GET(self, x_coord, y_coord, plant_id):
    #if not x_coord:
    #    return "Error:No X"
    #if not y_coord:
    #    return "Error:No Y"
    #if not plant_id:
    #    return "Error:Unknown Plant"
        if not self.broker.seedPlant(x_coord, y_coord, plant_id):
            return "fail"
        return self.broker.getField().toxml()

class dig(BaseView):
    def GET(self, x_coord, y_coord):
        if not y_coord:
            y_coord = None

        if not self.broker.digPlant(x_coord, y_coord):
            return "fail:cant' dig"
        else:
            return self.broker.getField().toxml()

        #return "Dig at X:"+x_coord+" Y:"+str(y_coord)

class turn(BaseView):
    def GET(self):
        self.broker.updateField()
        return self.broker.getField().toxml()


class image(BaseView):
    def GET(self,plant_id,state_id=None):

        cType = {
            "png":"images/png",
            "jpg":"image/jpeg",
            "gif":"image/gif",
            "ico":"image/x-icon"}

        if not plant_id: # background image requested
            sprite_name,image = self.broker.getBackgroundImage()
        else:
            sprite_name,image = self.broker.getPlantImage(plant_id,state_id)

        if not(sprite_name or image):
            return "fail: no image"

        ext =  sprite_name.split('.')[-1] # get extension

        web.header("Content-Type", cType[ext]) # Set the Header
        return image

class list(BaseView):
    def GET(self):
        return self.broker.getPlants().toxml();

def notFound():
    return web.notfound("!!!!! not found !!!!")
