sap.ui.define(["sap/ui/core/mvc/Controller",
    "com/teaminsightplatform/controller/baseController",
    "sap/uxap/ObjectPageLayout",
    "sap/uxap/ObjectPageSection",
    "sap/uxap/ObjectPageSubSection",
	"sap/ui/core/BusyIndicator"
], (Controller, BaseController, ObjectPageLayout, ObjectPageSection, ObjectPageSubSection,BusyIndicator) => {
        "use strict";

        return BaseController.extend("com.teaminsightplatform.controller.View", {
            onInit() {
                console.log("App controller initialized");
                console.log(this);
                // this.getRouter("main").attachPatternMatched(this._onObjectMatched, this);
                this.oTilesModel = this.getModel("tiles");
                try {
                    console.log("Tiles model loaded successfully");
                    console.log(this.oTilesModel.getData());
                } catch (error) {
                    console.error("Error loading tiles model:", error);
                    throw new Error("Failed to load tiles model");
                }
                try {
                    this.onSectionChange();
                    this.getRouter("RouteView").attachPatternMatched(
                        this._onRouteMatched,
                        this
                    );
                } catch (error) {
                    console.error("Error attaching route matched event:", error);
                }
            },
            _onRouteMatched(oEvent) {
                console.log("Route matched");
                console.log(this.getModel("tiles").getData());
                console.log("Iniciando geração de tiles, após o onSectionChange ser disparado");
                
            },
            onSectionChange() {
                console.log("Criando fragmentos internos");
                // Controle de acessos
                const aTiles = this.oTilesModel.getData().tiles;
                const aGroup = this.oTilesModel.getData().group;
                const aTypeRoute = this.oTilesModel.getData().type;
                this._createGroupTile(aGroup, aTiles, aTypeRoute);
            },
            _createGroupTile(aGroup, aTiles, aTypeRoute) {
                let idObjectPageLayout = this.getView().byId("idObjectPageLayout");
                aGroup.forEach((oGroup) => {
                    let aTilesFilter = aTiles.filter((oValue) => oValue.group === oGroup.id);
                    console.log(aTilesFilter);
                    console.log("Processing create  ObjectPageSection for group :", oGroup);
                    const oObjectPageSection = new ObjectPageSection({
                        title: oGroup.title,
                        id: `section-${oGroup.id}`,
                    });
                    idObjectPageLayout.addSection(oObjectPageSection);
                    const oObjectPageSubSection = new ObjectPageSubSection({
                        title: oGroup.label,
                    });
                    oObjectPageSection.addSubSection(oObjectPageSubSection);
                    aTilesFilter.forEach((oTileRef) => {
                        let oGenericTile = new sap.m.GenericTile({
                            header: oTileRef.label,
                            width: "100%",
                            press: this.onTilePress.bind(this),
                        });
                        oGenericTile.addStyleClass("sapUiSmallMargin");
                        if (oTileRef.icon) {
                            let oTileContent = new sap.m.TileContent({
                                content: new sap.m.ImageContent({
                                    src: oTileRef.icon
                                })
                            });

                            oGenericTile.addTileContent(oTileContent);


                            // oGenericTile.addTileContent(oTileContent);
                        }
                        let sRoute = aTypeRoute.find((oType) => oType.id === oTileRef.routeId);
                        let oTileContentRoute = new sap.ui.core.CustomData({
                            key: "route",
                            value: sRoute ? sRoute.route : "Not Found",
                        });
                        oGenericTile.addCustomData(oTileContentRoute);
                        let oValueRoute = { "idRoute": oTileRef.idKey };
                        let sValueRoute = btoa(JSON.stringify(oValueRoute));
                        let oTileContentId = new sap.ui.core.CustomData({
                            key: "idRoute",
                            value: sValueRoute ? sValueRoute : "Not Found",
                        });
                        oGenericTile.addCustomData(oTileContentId);
                        oObjectPageSubSection.addBlock(oGenericTile);
                    });
                    // const oGenericTile = new sap.m.GenericTile({
                    //     header: oGroup.id,
                    //     width: "100%",
                    // });
                    // oObjectPageSubSection.addBlock(oGenericTile);
                });
            },
            onTilePress(oEvent) {
                const oTile = oEvent.getSource();
                let sRoute = oTile.data().route;
                let sIdRoute = oTile.data().idRoute;
                if (sRoute && sRoute !== "Not Found") {
                    console.log("Navigating to route:", sRoute);
                    this.oContentModel = this.getModel("contentPage");
                    this.oContentModel.setProperty("/busy", true);
                    this._navTo("RouteView", sRoute, ({
                        query: {
                            idRoute: sIdRoute
                        }
                    }));
                } else {
                    console.error("Route not found for the pressed tile");
                }
                console.log("Tile pressed:", oTile.data().route);
                const sTileTitle = oTile.getHeader();
                console.log("Tile pressed:", sTileTitle);
                // const oFindTile = (new Set(this.getModel("tiles").getData().tiles));
                // const oFindRoute = (new Set(this.getModel("tiles").getData().type)).has(oFindTile);
                // this.getModel("tiles").getData().tiles.forEach((oTileRef) => {
                //     if (oTileRef.label === sTileTitle) {
                //         console.log("Navigating to route:", oTileRef.route);
                //         this._navTo("RouteView", oTileRef.route);
                //     }
                // });
            },
            
		onExit:function(){
BusyIndicator.hide();
		},
        });
    });
