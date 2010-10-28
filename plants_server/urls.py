__author__ = 'Andrei'

import views;

urls = (
    '/init','views.init',
    '/state','views.state',                # get current state of the field
    '/seed/(\d+)/(\d+)/(\d+)/?','views.seed', # seed plant at coords ex. seed/x/y/plant_id
    '/dig/(\d+)/?(\d+)?/?','views.dig',      # dig plant at coords ex. dig/x/y or dig/field_id
    '/image/?(\d+)?/?(\d+)?/?','views.image',  # get bitmap for plant ex. image/plant_id/state_id or image/plant_id (for 1-level)
    '/list','views.list',                  # get the list of all plants in the system
    '/turn','views.turn'                   # grow for one turn
)