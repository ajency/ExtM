define [ 'marionette', 'src/extm.application' ], ( Marionette )->

    describe "Extended marionette application", ->
        app = null
        beforeEach ->
            app = new Marionette.Application
            app.startHistory()

        afterEach ->
            Backbone.history.stop()
            app = null


        describe "get current route", ->
            it "must return exact current route", ->
                app.navigate "some-route", trigger : true
                expect app.getCurrentRoute()
                    .toBe "some-route"


        describe "navigate route", ->
            it "mus trigger a new route", ->
                app.navigate "some-route", trigger : true
                expect app.getCurrentRoute()
                    .toBe "some-route"
