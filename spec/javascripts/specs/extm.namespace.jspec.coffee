define ['src/extm.namespace'], ( Extm )->

   describe 'Extm Namespace', ->

      it 'must be defined', ->
         expect(Extm).toBeDefined()
         expect(Extm).toEqual jasmine.any Object