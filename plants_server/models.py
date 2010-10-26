__author__ = 'Andrei'

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