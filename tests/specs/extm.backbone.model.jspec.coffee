define ['backbone', 'src/extm.backbone.model'], (Backbone)->
    window.AJAXURL = ''
    describe "Backbone Model to support wordpress", ->
        handleRequest = jasmine.createSpy "handleRequest"
        describe "model create", ->
            model = {}

            beforeEach ->
                Model = Backbone.Model.extend {name : 'model'}
                model = new Model
                model.on 'create:request', handleRequest

            afterEach ->
                model = {}

            it "on save for creating a model", ->
                spyOn model, "sync"
                model.save {}
                expect model.sync
                    .toHaveBeenCalled()

            it "must trigger a GET request", ->
                xhr = model.save {}
                console.log xhr
                expect xhr
                    .toBeDefined()

            it "it must trigger the create:request event", ->
                model.save {}
                expect handleRequest
                    .toHaveBeenCalled()

        describe "model update", ->
            model = {}
            beforeEach ->
                Model = Backbone.Model.extend {name : 'model'}
                model = new Model id : 23
                model.on 'update:request', handleRequest

            afterEach ->
                model = {}

            it "it must trigger the update:request event", ->
                model.save {}
                expect handleRequest
                    .toHaveBeenCalled()



