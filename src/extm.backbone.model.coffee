define [ 'backbone', 'underscore' ], ( Backbone, _ )->

    _.extend Backbone.Model::,

        sync : (method, model, options)->

            # check if the name property is set for the model
            # this property is important because the “action”
            # param required for wordpress ajax is generated
            # combining “#{method}-#{name}”
            if not @name
                throw new Error "'name' property not set for the model"

            # throw error if "AJAXURL" is not set
            if _.isUndefined AJAXURL
                throw new Error "'AJAXURL' not set. Please set window.AJAXURL"

            # Default JSON-request options.
            params =
                type : "POST"
                dataType : "json"
                data : {}

            # All ajax request in wordpress are sent to admin_url(‘admin-ajax.php’)
            # a global AJAXURL variable must be defined for all ajax actions
            # so, the url is always AJAXURL
            params.url = AJAXURL || ""

            # generate the “action” param and bind it to data attribute of ‘params’
            _action = "#{method}-#{@name}"
            params.data['action'] = _action

            # handle various CRUD operations depending on method name
            switch method

                # read a model form server. the only property read a model from server is the
                # id attribute of the model.
                when 'read'
                    # read action must trigger a GET request. set the request to GET
                    params.type = 'GET'

                    # get the id attribute of the model
                    idAttr = model['idAttribute']
                    params.data[idAttr] = model.get idAttr

                # create a new model. At this point the model id/idAttribute is not set
                # the required data to create the model is present inside model. so model.toJSON()
                when 'create'
                    params.data = _.defaults model.toJSON(), params.data

                # update a model. Two possible options, send entire model data to server or send
                # only updated one. This condition will be handled with options passed along save
                # options name is ‘onlyChanged’ accepting boolean value. default to ‘true’
                when 'update'
                    onlyChanged = options.onlyChanged ? false

                    idAttr = model['idAttribute']

                    if onlyChanged
                        params.data[idAttr] = model.get idAttr
                        # get all changed values and add them to param’s data attribute
                        if model.hasChanged()

                            params.data.changes = {}

                            _.each model.changed, (changeAttributeValue, changeAttributeName)->
                                #params.data.changes[ property ] = this.get property
                                params.data.changes[ changeAttributeName ] = changeAttributeValue
                            , @
                    else
                        # put all model data in params data attribute
                        params.data = _.defaults model.toJSON(), params.data

                # deleting a model. This will need only the id of the model to send to server. Different model
                # can have different idAttributes, hence, get the id attribute first and set it as the data attributes
                # property.
                when 'delete'
                    allData = options.allData ? true
                    if allData
                        # put all model data in params data attribute
                        params.data = _.defaults model.toJSON(), params.data
                    else
                        # get the model’s idAttribute. can be other then ‘id’
                        idAttr = model['idAttribute']
                        params.data[idAttr] = model.get idAttr
                else
                    return

            # Don't process data on a non-GET request.
            # params.processData = false  if params.type isnt "GET" and not options.emulateJSON

            # Make the request, allowing the user to override any Ajax options.
            xhr = options.xhr = Backbone.ajax(_.extend(params, options))

            # trigger the request event of the model
            model.trigger "#{method}:request", model, xhr, options

            # attache _fetch to model
            model["_#{method}"] = xhr

            # return the xhr object. this is a jquery deffered object
            xhr

