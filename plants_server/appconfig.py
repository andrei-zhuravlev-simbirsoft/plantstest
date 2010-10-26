__author__ = 'Andrei'

config_file = "config.ini"

import ConfigParser

cfg = ConfigParser.RawConfigParser()
cfg.read('config.ini')


class Config:
    def __init__(self):
        self.db_user = cfg.get('database',"user")
        self.db_pw = cfg.get('database',"pass")
        self.db_db = cfg.get('database',"db")

        self.field_x = cfg.get("game","field_x")
        self.field_y = cfg.get("game","field_y")

        self.res_dir = cfg.get("resources","dir")
        self.background = cfg.get("resources","background")






  