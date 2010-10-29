__author__ = 'Andrei'

from xml.dom import minidom

class Plant(object):

    def __init__(self,id=None,plant_id=None,x=None,y=None,name=None,state_id=None,state=None):
        self.id = id
        self.plant_id = plant_id
        self.x = x
        self.y = y
        self.name = name
        self.state_id = state_id
        self.state = state


class Error(object):
    def __init__(self,id=None,message=None):
        self.id = id
        self.message = message

    def asXML(self, id=None, msg=None):

        if not id:
            id = self.id
        if not msg:
            msg = self.message

        xml = minidom.Document()
        err = xml.createElement("error")
        err.setAttribute('id', id)
        err.setAttribute('message', msg)
        xml.appendChild(err)
        return xml.toxml()