# Region controller spec
define [ 'marionette', 'src/extm.marionette.regioncontroller' ], ( Marionette )->

    describe "Extended Marionette region controller", ->

        describe "when creating a new controller without a region", ->

            it "must throw an error", ->
                expect Marionette.RegionController.extend()
                    .toThrow()

        describe "On initialization", ->

            regionController = {}

            beforeEach ->
                regionController = new Marionette.RegionController

            it "must just work!!!", ->
                expect regionController
                    .toBeDefined()