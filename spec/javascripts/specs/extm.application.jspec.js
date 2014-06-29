// Generated by CoffeeScript 1.7.1
describe('ExtmAplication', function() {
  it('must be defined', function() {
    expect(Extm.Application).toBeDefined();
    return expect(Extm.Application).toEqual(jasmine.any(Function));
  });
  it('must have default route to be ""', function() {
    var App;
    App = new Extm.Application;
    return expect(App.defaultRoute).toBe('');
  });
  describe('when have a default route equal to "some-route"', function() {
    return it('must have default route to be "some-route"', function() {
      var App;
      App = new Extm.Application;
      App.setDefaultRoute('some-route');
      return expect(App.defaultRoute).toBe('some-route');
    });
  });
  describe('when app starts without adding any regions', function() {
    var app;
    afterEach(function() {
      return Backbone.history.stop();
    });
    app = new Extm.Application;
    return it('must throw an error', function() {
      return expect(function() {
        return app.start();
      }).toThrow();
    });
  });
  describe('when app starts with region hash', function() {
    var App;
    App = '';
    beforeEach(function() {
      App = new Extm.Application;
      App.onStart = function() {};
      spyOn(App, 'onStart');
      App.addRegions({
        regionName: '#region-element'
      });
      return App.start();
    });
    afterEach(function() {
      Backbone.history.stop();
      return App = {};
    });
    it('must set the app region', function() {
      return expect(App.getRegion('regionName') instanceof Marionette.Region).toBeTruthy();
    });
    it('must still have default functionality of Marionette.Application', function() {
      return expect(App.onStart).toHaveBeenCalled();
    });
    return it('must start the backbone history', function() {
      return expect(App.histroyStarted).toBeTruthy();
    });
  });
  describe('when current route is empty', function() {
    var App;
    App = '';
    beforeEach(function() {
      window.location.hash = '';
      App = new Extm.Application;
      return App.addRegions({
        regionName: '#region-element'
      });
    });
    afterEach(function() {
      Backbone.history.stop();
      return App = {};
    });
    it('must navigate to "" route', function() {
      App.start();
      return expect(App.getCurrentRoute()).toBe('');
    });
    return it('must navigate to default route', function() {
      App.setDefaultRoute('new-route');
      App.start();
      return expect(App.getCurrentRoute()).toBe('new-route');
    });
  });
  return describe('when current route not empty', function() {
    var app;
    app = {};
    beforeEach(function() {
      window.location.hash = '#/some-hash';
      app = new Extm.Application;
      app.addRegions({
        regionName: '#region-element'
      });
      return app.start();
    });
    afterEach(function() {
      Backbone.history.stop();
      window.location.hash = '';
      return app = {};
    });
    return it('must navigate to default route', function() {
      return expect(app.getCurrentRoute()).toBe('some-hash');
    });
  });
});
