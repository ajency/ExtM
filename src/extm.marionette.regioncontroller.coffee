define [ 'marionette', 'backbone', 'underscore' ], ( Marionette, Backbone, _ )->

    # Extended controller for marionette app
    # This controller is specially designed to work with Region.
    class Marionette.RegionController extends Marionette.Controller

        # constructor
        constructor : ( options )->

            # set the region
            @region = options.region || msgbus.request "get:default:region"

            # capture the reference to msgbus
            @msgbus = msgbus

            # create a entities property to store all entities
            @entities = {}

            super options

        close : ( args... )->
            # clean up process
            delete @region
            delete @msgbus
            delete @request
            delete @execute
            delete @vent
            super args

        requestFor : ( handle, args )->
            @msgbus.reqres.request handle, args

        showSubApp : ( handle, options )->
            @msgbus.commands.execute handle, options

        notify : ( message )->
            @msgbus.commands.execute "show:notification", message

        addEntity : ( key, entity )->
            # sanitize key value
            # TODO: handle key sanitization
            if not _.isUndefine key
                throw new Error "This entity already exists in entities hash."

            @entities[key] = entity

        createNewChannel : ( name = '' )->
            #TODO: Sanitize name value
            Backbone.Wreqr.radio.channel name




