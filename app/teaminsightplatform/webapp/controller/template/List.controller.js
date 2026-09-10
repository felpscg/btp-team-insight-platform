sap.ui.define(["sap/ui/core/mvc/Controller",
    "com/teaminsightplatform/controller/baseController",
    "sap/uxap/ObjectPageLayout",
    "sap/uxap/ObjectPageSection",
    "sap/uxap/ObjectPageSubSection",
    "sap/ui/core/BusyIndicator"
], (Controller, BaseController, ObjectPageLayout, ObjectPageSection, ObjectPageSubSection, BusyIndicator) => {
    "use strict";

    return BaseController.extend("com.teaminsightplatform.controller.template.List", {
        onInit() {
            try {

                this.getRouter("RouteList").attachPatternMatched(
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
            this.oContentModel.setProperty("/busy", true);
            console.log("Route matched RouteList");
            console.log(this.getModel("contentPage").getData());
            var oArgs = oEvent.getParameter("arguments");
            console.log("Arguments from route:", atob(oArgs['?query'].idRoute));
            this.oTilesModel = this.getModel("tiles");
            let aTiles = this.getModel("tiles").getData().tiles;
            console.log(aTiles);
            let sIdTile = JSON.parse(atob(oArgs['?query'].idRoute));
            console.log("Tile ID:", sIdTile.idRoute);
            console.log("Tile Content:", aTiles[sIdTile.idRoute]);
            this.oContentModel.setProperty("/content/", aTiles[sIdTile.idRoute]);
            console.log("Content model updated with tile content:", this.oContentModel.getData());
            this.onContentChange();
            this.oContentModel.setProperty("/busy", false);
        },
        onContentChange() {
            console.log("Criando fragmentos internos");
        }
    });
});
