// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'app/js/apps/header/header-view'], function(Extm, HeaderView) {
  var HeaderController;
  HeaderController = (function(_super) {
    __extends(HeaderController, _super);

    function HeaderController() {
      return HeaderController.__super__.constructor.apply(this, arguments);
    }

    HeaderController.prototype.initialize = function(options) {
      var view;
      view = options.view;
      this.store().find('view', view);
      this.store().find('unit', {
        building: 54
      });
      return this.wait();
    };

    HeaderController.prototype.onComplete = function(model, collection) {
      return this.show(new HeaderView({
        collection: collection,
        model: model
      }));
    };

    return HeaderController;

  })(Extm.RegionController);
  msgbus.registerController('header', HeaderController);
  return HeaderController;
});
