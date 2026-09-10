sap.ui.define(["sap/ui/core/mvc/Controller",
    "com/teaminsightplatform/controller/baseController",
    "sap/uxap/ObjectPageLayout",
    "sap/uxap/ObjectPageSection",
    "sap/uxap/ObjectPageSubSection",
    "sap/ui/core/BusyIndicator"
], (Controller, BaseController, ObjectPageLayout, ObjectPageSection, ObjectPageSubSection, BusyIndicator) => {
    "use strict";

    return BaseController.extend("com.teaminsightplatform.controller.template.Analytics", {
        onInit() {
            try {
                
                this.getRouter("RouteAnalytics").attachPatternMatched(
                    this._onRouteMatched,
                    this
                );
            } catch (error) {
                console.error("Error attaching route matched event:", error);
            }
        },

        _onRouteMatched(oEvent) {
            console.log(this);
            // this.getRouter("main").attachPatternMatched(this._onObjectMatched, this);
            this.oContentModel = this.getModel("contentPage");
            console.log("Route matched RouteAnalytics");
            console.log(this.getModel("contentPage").getData());
            this.onContentChange();

        },
        onContentChange() {
            console.log("Criando fragmentos internos");
        }
    });
});
