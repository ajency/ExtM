(function ( root, factory ) {

    var babysitter, backbone, underscore, wreqr;

    if (typeof exports === "object") {

        underscore = require( "underscore" );
        backbone = require( "backbone" );
        wreqr = require( "backbone.wreqr" );
        babysitter = require( "backbone.babysitter" );

        return module.exports = factory( underscore, backbone, wreqr, babysitter );

    } else if (typeof define === "function" && define.amd) {
        return define( ["underscore",
                        "backbone",
                        "marionette",
                        "mustache",
                        "async",
                        "jqueryvalidate"], factory );
    }

})( this, function ( _, Backbone, Marionette, Mustache, async ) {

    
    var Extm;
    
    Extm = (function ( global, Backbone, _ , Marionette, Mustache, async) {
    
        "use strict";
    
        Extm = {};
        Extm.$ = Backbone.$;
    
        // Generated by CoffeeScript 1.7.1
        _.extend(Backbone.Model.prototype, {
          sync: function(method, model, options) {
            var allData, idAttr, onlyChanged, params, xhr, _action, _ref, _ref1;
            if (!this.name) {
              throw new Error("'name' property not set for the model");
            }
            params = {
              type: "POST",
              dataType: "json",
              data: {}
            };
            params.url = AJAXURL;
            _action = "" + method + "-" + this.name;
            params.data['action'] = _action;
            switch (method) {
              case 'read':
                params.type = 'GET';
                idAttr = model['idAttribute'];
                params.data[idAttr] = model.get(idAttr);
                break;
              case 'create':
                params.data = _.defaults(model.toJSON(), params.data);
                break;
              case 'update':
                onlyChanged = (_ref = options.onlyChanged) != null ? _ref : false;
                idAttr = model['idAttribute'];
                if (onlyChanged) {
                  params.data[idAttr] = model.get(idAttr);
                  if (model.hasChanged()) {
                    params.data.changes = {};
                    _.each(model.changed, function(changeAttributeValue, changeAttributeName) {
                      return params.data.changes[changeAttributeName] = changeAttributeValue;
                    }, this);
                  }
                } else {
                  params.data = _.defaults(model.toJSON(), params.data);
                }
                break;
              case 'delete':
                allData = (_ref1 = options.allData) != null ? _ref1 : true;
                if (allData) {
                  params.data = _.defaults(model.toJSON(), params.data);
                } else {
                  idAttr = model['idAttribute'];
                  params.data[idAttr] = model.get(idAttr);
                }
            }
            xhr = options.xhr = Backbone.ajax(_.extend(params, options));
            model.trigger("" + method + ":request", model, xhr, options);
            model["_" + method] = xhr;
            return xhr;
          }
        });
        
    
        // Generated by CoffeeScript 1.7.1
        var _Controllers;
        
        Extm._Controllers = _Controllers = {};
        
    
        // Generated by CoffeeScript 1.7.1
        var AppLauncher;
        
        AppLauncher = (function() {
          AppLauncher.prototype.region = null;
        
          AppLauncher.prototype.options = {};
        
          AppLauncher.prototype.appName = '';
        
          function AppLauncher(appName) {
            this.appName = appName;
          }
        
          AppLauncher.prototype.insideRegion = function(region) {
            this.region = region;
            return this;
          };
        
          AppLauncher.prototype.withOptions = function(options) {
            this.options = _.defaults({
              region: this.region
            }, options);
            return this._launch();
          };
        
          AppLauncher.prototype._launch = function() {
            var Controller;
            Controller = this._getControllerClass();
            new Controller(this.options);
            return this._deleteReference();
          };
        
          AppLauncher.prototype._getControllerClass = function() {
            if (_.isUndefined(_Controllers[this.appName])) {
              throw new Error('No such controller registered');
            }
            return _Controllers[this.appName];
          };
        
          AppLauncher.prototype._deleteReference = function() {
            delete this.region;
            delete this.options;
            return delete this.appName;
          };
        
          return AppLauncher;
        
        })();
        
        // Generated by CoffeeScript 1.7.1
        Extm.Store = (function() {
          function Store() {}
        
          Store.prototype.models = {};
        
          Store.prototype.find = function(name, args) {
            var collection, model, models, _models;
            if (args == null) {
              args = null;
            }
            _models = this.models;
            if (_.isUndefined(this.models[name])) {
              this.models[name] = new Backbone.Collection;
            }
            if (_.isNull(args)) {
              this.models[name].url = "" + AJAXURL;
              return $.Deferred(function(deferred) {
                if (_models[name].length === 0) {
                  return _models[name].fetch({
                    data: {
                      action: "fetch-" + name + "s"
                    },
                    success: function(collection) {
                      return deferred.resolve(collection);
                    },
                    error: function(error) {
                      return deferred.reject(error);
                    }
                  });
                } else {
                  return deferred.resolve(_models[name]);
                }
              }).promise();
            }
            if (_.isNumber(args)) {
              model = this.models[name].get(args);
              if (!model) {
                model = new Backbone.Model;
                model.name = name;
                model.set('id', args);
                return $.Deferred(function(deferred) {
                  return model.fetch({
                    success: function(model) {
                      _models[name].add(model);
                      return deferred.resolve(model);
                    },
                    error: function(error) {
                      return deferred.reject(error);
                    }
                  });
                }).promise();
              }
              return $.Deferred(function(deferred) {
                return deferred.resolve(model);
              }).promise();
            }
            if (_.isArray(args)) {
              models = [];
              _.each(args, function(id) {
                model = _models[name].get(id);
                if (!_.isUndefined(model)) {
                  return models.push(model);
                }
              });
              collection = new Backbone.Collection(models);
              if (args.length !== collection.length) {
                collection.url = "" + AJAXURL;
                return $.Deferred(function(deferred) {
                  return collection.fetch({
                    add: true,
                    remove: false,
                    data: {
                      action: "fetch-" + name + "s",
                      ids: args
                    },
                    success: function(collection) {
                      _models[name].add(collection.models);
                      return deferred.resolve(collection);
                    },
                    error: function(error) {
                      return deferred.reject(error);
                    }
                  });
                }).promise();
              }
              return $.Deferred(function(deferred) {
                return deferred.resolve(collection);
              }).promise();
            }
            if (_.isObject(args)) {
              models = this.models[name].where(args);
              collection = new Backbone.Collection(models);
              if (collection.length === 0) {
                collection.url = "" + AJAXURL;
                return $.Deferred(function(deferred) {
                  return collection.fetch({
                    data: {
                      action: "fetch-" + name + "s",
                      filters: args
                    },
                    success: function(collection) {
                      _models[name].add(collection.models);
                      return deferred.resolve(collection);
                    },
                    error: function(error) {
                      return deferred.reject(error);
                    }
                  });
                }).promise();
              }
              return $.Deferred(function(deferred) {
                return deferred.resolve(collection);
              }).promise();
            }
          };
        
          Store.prototype.push = function(name, value) {
            var model;
            if (_.isUndefined(this.models[name])) {
              this.models[name] = new Backbone.Collection;
            }
            if (_.isArray(value)) {
              return _.each(value, (function(_this) {
                return function(attr, index) {
                  var model;
                  model = new Backbone.Model(attr);
                  model.name = name;
                  return _this.models[name].add(model);
                };
              })(this));
            } else if (_.isObject(value)) {
              model = new Backbone.Model(attr);
              model.name = name;
              return this.models[name].add(model);
            }
          };
        
          Store.prototype._findAll = function() {};
        
          Store.prototype._query = function() {};
        
          return Store;
        
        })();
        
        // Generated by CoffeeScript 1.7.1
        window.msgbus = Backbone.Wreqr.radio.channel("global");
        
        msgbus.request = function() {
          return msgbus.reqres.request.apply(msgbus.reqres, arguments);
        };
        
        msgbus.execute = function() {
          return msgbus.commands.request.apply(msgbus.commands, arguments);
        };
        
        msgbus.registerController = function(name, controller) {
          return _Controllers[name] = controller;
        };
        
        msgbus.registerModel = function(name, model) {
          return _Models[name] = model;
        };
        
        msgbus.showApp = function(appName) {
          var appLauncher;
          appLauncher = new AppLauncher(appName);
          return appLauncher;
        };
        
        msgbus._store = new Extm.Store;
        
    
        // Generated by CoffeeScript 1.7.1
        var __hasProp = {}.hasOwnProperty,
          __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
        
        Extm.Application = (function(_super) {
          __extends(Application, _super);
        
          Application.prototype._staticApps = [];
        
          Application.prototype.histroyStarted = false;
        
          Application.prototype.defaultRoute = '';
        
          function Application(options) {
            if (options == null) {
              options = {};
            }
            this.store = msgbus._store;
            Application.__super__.constructor.call(this, options);
          }
        
          Application.prototype.start = function(options) {
            if (options == null) {
              options = {};
            }
            if (_.size(this.getRegions()) === 0) {
              throw new Error('application regions not specified');
            }
            Application.__super__.start.call(this, options);
            return this.startHistory();
          };
        
          Application.prototype._setUpRegions = function(regions) {
            return this.addRegions(regions);
          };
        
          Application.prototype.startHistory = function() {
            if (!this.histroyStarted) {
              Backbone.history.start();
              if (this.getCurrentRoute() === '') {
                this.navigate(this.defaultRoute, {
                  trigger: true
                });
              }
              this.histroyStarted = true;
              if (this._hasStaticApps()) {
                return this._startStaticApps();
              }
            }
          };
        
          Application.prototype.navigate = function(route, options) {
            return Backbone.history.navigate(route, options);
          };
        
          Application.prototype.setDefaultRoute = function(route) {
            if (route == null) {
              route = '';
            }
            return this.defaultRoute = route;
          };
        
          Application.prototype.getCurrentRoute = function() {
            var frag;
            frag = Backbone.history.fragment;
            if (_.isEmpty(frag)) {
              return '';
            } else {
              return frag;
            }
          };
        
          Application.prototype.addStaticApps = function(apps) {
            return this._staticApps = apps;
          };
        
          Application.prototype._hasStaticApps = function() {
            return _.size(this._staticApps) > 0;
          };
        
          Application.prototype._startStaticApps = function() {
            return _.each(this._staticApps, function(app, index) {
              return msgbus.showApp(app[0]).insideRegion(app[1]).withOptions(_.isUndefined(app[2]) ? {} : app[2]);
            });
          };
        
          return Application;
        
        })(Marionette.Application);
        
        // Generated by CoffeeScript 1.7.1
        var __hasProp = {}.hasOwnProperty,
          __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
          __slice = [].slice;
        
        Extm.RegionController = (function(_super) {
          __extends(RegionController, _super);
        
          function RegionController(options) {
            if (options == null) {
              options = {};
            }
            this.region = false;
            this.currentView = false;
            this._promises = [];
            if (!options.region) {
              throw new Error('Region is not specified for the controller');
            }
            this._assignRegion(options.region);
            this.instanceId = _.uniqueId('region-controller-');
            msgbus.commands.execute('register:controller', this.instanceId, this);
            RegionController.__super__.constructor.call(this, options);
          }
        
          RegionController.prototype._assignRegion = function(region) {
            return this.region = region;
          };
        
          RegionController.prototype.store = function() {
            return this;
          };
        
          RegionController.prototype.find = function(name, args) {
            var promise;
            promise = msgbus._store.find(name, args);
            this._promises.push(promise);
            return promise;
          };
        
          RegionController.prototype.wait = function() {
            return $.when.apply($, this._promises).done((function(_this) {
              return function() {
                var resolved;
                resolved = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
                resolved.unshift('complete');
                return _this.triggerMethod.apply(_this, resolved);
              };
            })(this));
          };
        
          RegionController.prototype.destroy = function() {
            var args;
            args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
            delete this.region;
            delete this.currentView;
            delete this.options;
            msgbus.commands.execute("unregister:controller", this.instanceId, this);
            return RegionController.__super__.destroy.call(this, args);
          };
        
          RegionController.prototype.show = function(view) {
            this.currentView = view;
            return this.region.show(view);
          };
        
          return RegionController;
        
        })(Marionette.Controller);
        
        // Generated by CoffeeScript 1.7.1
        Marionette.Renderer.render = function(template, data) {
          if (data == null) {
            data = {};
          }
          if (!template) {
            template = '';
          }
          return Mustache.to_html(template, data);
        };
        
    
        // Generated by CoffeeScript 1.7.1
        var __hasProp = {}.hasOwnProperty,
          __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
        
        Extm.FormView = (function(_super) {
          __extends(FormView, _super);
        
          function FormView() {
            return FormView.__super__.constructor.apply(this, arguments);
          }
        
          FormView.prototype.tagName = 'form';
        
          FormView.prototype.className = 'extm-form-view';
        
          FormView.prototype.onShow = function() {
            return this.$el.validate();
          };
        
          return FormView;
        
        })(Marionette.ItemView);
        
        // Generated by CoffeeScript 1.7.1
        var __hasProp = {}.hasOwnProperty,
          __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
        
        Extm.FormLayoutView = (function(_super) {
          __extends(FormLayoutView, _super);
        
          function FormLayoutView() {
            return FormLayoutView.__super__.constructor.apply(this, arguments);
          }
        
          FormLayoutView.prototype.tagName = 'form';
        
          FormLayoutView.prototype.className = 'extm-form-layout-view';
        
          FormLayoutView.prototype.onShow = function() {
            return this.$el.validate();
          };
        
          return FormLayoutView;
        
        })(Marionette.LayoutView);
        
    
        return Extm;
    
    })( this, Backbone, _, Marionette, Mustache, async );

    Marionette.Extm = Extm;

    return Extm;
} );
