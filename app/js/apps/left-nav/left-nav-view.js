// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['extm', 'marionette'], function(Extm, Marionette) {
  var CView, LeftNavView;
  CView = (function(_super) {
    __extends(CView, _super);

    function CView() {
      return CView.__super__.constructor.apply(this, arguments);
    }

    CView.prototype.tagName = 'li';

    CView.prototype.template = '{{name}}';

    return CView;

  })(Marionette.ItemView);
  return LeftNavView = (function(_super) {
    __extends(LeftNavView, _super);

    function LeftNavView() {
      return LeftNavView.__super__.constructor.apply(this, arguments);
    }

    LeftNavView.prototype.childView = CView;

    LeftNavView.prototype.childViewContainer = 'ul';

    LeftNavView.prototype.template = '<div>view name : {{name}} <img src="{{picture}}" /> </div> <ul></ul>';

    return LeftNavView;

  })(Marionette.CompositeView);
});
