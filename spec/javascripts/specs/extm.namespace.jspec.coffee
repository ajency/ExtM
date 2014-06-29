define [ 'src/extm.namespace' ], ( Extm )->

   describe 'Extm namsepace', ->

      it 'must have all objects defined', ->
         expect(Extm.Application).toBeDefined()