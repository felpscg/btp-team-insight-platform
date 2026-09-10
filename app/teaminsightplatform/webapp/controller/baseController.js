/*eslint-disable no-console, no-alert, sap-no-hardcoded-url */

sap.ui.define([
	"sap/ui/core/mvc/Controller",
	"sap/ui/core/UIComponent",
	"sap/m/library",
	"sap/m/Dialog",
	"sap/m/Text",
	"sap/m/Button",
	"sap/ui/core/routing/History",
	"sap/m/MessageBox",
	"sap/ui/core/library"
], function (Controller, UIComponent, mobileLibrary, Dialog, Text, Button, History, MessageBox, CoreLibrary) {
	"use strict";
	var ValueState = CoreLibrary.ValueState;
	var ButtonType = mobileLibrary.ButtonType;

	return Controller.extend("com.teaminsightplatform.controller.baseController", {
		/**
		 * Convenience method for accessing the router.
		 * @public
		 * @returns {sap.ui.core.routing.Router} the router for this component
		 */
		iTempNumb: 0.00,
		jTempNumb: 0.00,
		bFLAGFIRST: true,
		getRouter: function ( event) {

    // In your controller
    // const oRouter = this.getOwnerComponent().getRouter();
    // const sHash = oRouter.getHashChanger().getHash();
    // const oRouteInfo = oRouter.getRouteInfoByHash(sHash);

    // if (oRouteInfo) {
    //     const sRouteName = oRouteInfo.name; // Get the name
    //     const oRoute = oRouter.getRoute(sRouteName); // Get the route object
    //     console.log(sRouteName);
    // }

        return this.getOwnerComponent().getRouter(this).getRoute(event);
    },
	_navTo: function (sNameRoute, sRouteNav, oParameters ) {
			// this.getRouter().navTo(sName, oParameters);
			this.getOwnerComponent().getRouter(sNameRoute).navTo(sRouteNav,oParameters);
		},

		getCore: function () {
			return sap.ui.getCore();
		},
		/**
		 * Convenience method for getting the view model by name.
		 * @public
		 * @param {string} [sName] the model name
		 * @returns {sap.ui.model.Model} the model instance
		 */
		getModel: function (sName) {
			// return this.getView().getModel(sName);
			return this.getOwnerComponent().getModel(sName);
		},
        // getRouter: function (sName) {
        //     return UIComponent.getRouterFor(this);
        // },
		/**
		 * Convenience method for setting the view model.
		 * @public
		 * @param {sap.ui.model.Model} oModel the model instance
		 * @param {string} sName the model name
		 * @returns {sap.ui.mvc.View} the view instance
		 */
		setModel: function (oModel, sName) {
			return this.getView().setModel(oModel, sName);
		},

		_messageDialog: function (iState, sText, iBack, sPath) {
			var oDialog = new Dialog({
				title: iState,
				type: 'Message',
				state: iState,
				content: new Text({
					text: sText
				}),
				beginButton: new Button({
					type: ButtonType.Emphasized,
					text: 'OK',
					press: function () {
						oDialog.close();
						if (iBack === true) {
							this._onNavBack(sPath);
						}
					}.bind(this)
				}),
				afterClose: function () {
					oDialog.destroy();
				}
			});
			oDialog.open();
		},

		validateValueDouble: function (oEvent) {
			this.inputValueDouble(oEvent, 2, 6);
		},

		inputValueDouble: function (oEvent, fixed, iLim) {
			var oInput = oEvent.getSource(),
				sValue = oInput.getValue();
			var expValNum = /^[0-9]+$/;
			var expVal = /[0-9]+.[0-9]+/;
			if (sValue.length <= iLim && expValNum.test(sValue.replace(".", ""))) {
				console.log(sValue.replace(".", ""));
				if (expValNum.test(sValue.replace(".", "")))
					this.iTempNumb = (expVal.test(sValue) && expValNum.test(sValue)) ? (parseFloat(sValue).toFixed(fixed)) : ((expValNum.test(sValue)) ?
						(parseFloat(sValue).toFixed(fixed)) : (""));
				if ((this.bFLAGFIRST || sValue.length === 1)) {
					var zero = "0.";
					for (var i = 0; i < fixed - 1; i++) {
						zero = zero + "0";
						console.log(i);
					}
					console.log(zero);
					oInput.setValue(zero.concat(sValue));
					sValue = oInput.getValue();
					this.bFLAGFIRST = false;
					this.jTempNumb = this.iTempNumb;
				} else if (sValue === "") {
					this.bFLAGFIRST = true;
				} else if (!expVal.test(sValue)) {
					oInput.setValue(this.jTempNumb);
				} else {
					var secValue = sValue.replace(".", "");
					var aValue = secValue.split("");
					var tempArr = [];
					for (var i = 0; i < aValue.length; i++) {
						if (i === aValue.length - (fixed + 1)) {
							tempArr.push(aValue[i]);
							tempArr.push(".");
						} else {
							tempArr.push(aValue[i]);
						}
					}
					// Log.warning("sValue");Log.info(parseFloat(sValue).toFixed(2));Log.info("this.iTempNumb");Log.info(this.iTempNumb);
					if (aValue.length <= (fixed + 1) && (this.iTempNumb <= this.jTempNumb || parseFloat(sValue).toFixed(fixed) <= this.iTempNumb)) {
						this.removeVal(oEvent, aValue.length, fixed);
					} else {
						oInput.setValue(parseFloat(tempArr.join('')).toFixed(fixed));
						this.jTempNumb = this.iTempNumb;
						this.iTempNumb = parseFloat(tempArr.join('')).toFixed(fixed);
					}
					// this.jTempNumb = this.iTempNumb;
				}
			} else
				oInput.setValue(this.iTempNumb);
		},
		removeVal: function (oEvent, iQtdArrValue, fixed) {
			var oInput = oEvent.getSource(),
				tempArr = [],
				aTempDec = (((this.jTempNumb).toString()).replace(".", "")).split("");
			var j = (iQtdArrValue.length < 2) ? (0) : (1);
			if (iQtdArrValue === 2) {
				tempArr.push(aTempDec[0]);
			} else
				tempArr.push("0");
			tempArr.push(".");
			for (var i = 0; i < fixed - 1; i++) {
				tempArr.push("0");
			}

			while (j + ((iQtdArrValue === 2) ? (0) : (-fixed)) < iQtdArrValue + (iQtdArrValue === 2) ? (-fixed) : (0)) {
				tempArr.push(aTempDec[j + ((iQtdArrValue === 2) ? (0) : (-fixed))]);
				j++;
			}
			oInput.setValue(parseFloat(tempArr.join('')).toFixed(fixed));
			this.iTempNumb = parseFloat(tempArr.join('')).toFixed(fixed);
			this.jTempNumb = this.iTempNumb;
		},
		validateChangeDate: function (oEvent) {
			var bValid = oEvent.getParameter("valid"),
				oEventSource = oEvent.getSource();

			if (bValid) {
				oEventSource.setValueState(ValueState.None);
			} else {
				oEventSource.setValue("");
				oEventSource.setValueState(ValueState.Error);
			}
		},
		onValidateComboBox: function (oEvent) {
			var oComboBox = oEvent.getSource(),
				sKey = oComboBox.getSelectedItem(),
				sValue = oComboBox.getValue();

			if (sValue !== "" && sKey === null) {
				oComboBox.setValue("");
				oComboBox.setValueState("Error");
			} else {
				oComboBox.setValueState("None");
			}
		},

		_getDateTimeBRsplit: function (oDatex) {
			var oDate = oDatex;

			if (!oDate) {
				oDate = new Date();
			}

			var dOptions = {
				dateStyle: ("short"),
				timeStyle: ("medium")
			};

			var dateBr = oDate.toLocaleString("pt-BR", {
					timeZone: "America/Sao_Paulo"
				}, dOptions),
				aDateTime = dateBr.split(" "),
				oDateF = aDateTime[0],
				aDateF = oDateF.split("/"),
				oTimeF = aDateTime[1],
				aTimeF = oTimeF.split(":");

			return {
				dia: aDateF[0],
				mes: aDateF[1],
				ano: aDateF[2],
				hora: aTimeF[0],
				minuto: aTimeF[1],
				segundo: aTimeF[2]
			};
		},

		_convertToJSONDate: function (dia, mes, ano) {
			var newDate = new Date(Date.UTC(ano, mes, dia));
			return '/Date(' + newDate.getTime() + ')/';
		},

		_convertToJSONTime: function (hora, minuto, segundo) {
			return "PT" + hora + "H" + minuto + "M" + segundo + "S";
		},

		_convertDatetoJSONTime: function (oDatex) {
			var oDate = oDatex;

			if (!oDate) {
				oDate = new Date();
			}

			var oTypeTime = new sap.ui.model.odata.type.DateTime({
				pattern: "PTHH'H'mm'M'ss'S'"
			});

			return oTypeTime.formatValue(oDate, "string");
		},

		_onNavBack: function (sPath) {
			var sPreviousHash = History.getInstance().getPreviousHash();
			// sHistory = Utils.returnNow(sPath);
			console.log(sPreviousHash, sPath);
			if (sPreviousHash === sPath) {
				window.history.go(-1);
			} else {
				sap.ui.core.UIComponent.getRouterFor(this).navTo(sPath, true);
			}
		},
		_onNavBackPath: function (sPath, sName) {
			var oHistory = History.getInstance(),
				sPreviousHash = oHistory.getPreviousHash();
			// var sHistory = Utils.returnNow(sPath);
			if (sPreviousHash)
				sPreviousHash = sPreviousHash.split("/")[0];
			if (sPreviousHash === sPath) {
				window.history.go(-1);
			} else {
				var oRouter = sap.ui.core.UIComponent.getRouterFor(this);
				
				if (sName) {
					oRouter.navTo(sPath, {
						objetoID: sName
					});
				} else {
					oRouter.navTo(sPath, true);
				}
			}
		},
		_messageBox: function (sText, handleFunction) {
			MessageBox.confirm(sText, {
				onClose: function (sAction) {
					// handleFunction(sAction);
				}.bind(this)
			});
		},
		getResourceBundle: function () {
			return this.getOwnerComponent().getModel("i18n").getResourceBundle();
		}

	});

});