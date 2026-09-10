const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

    this.before('READ', 'Users', async (req) => { 

        console.log('Before READ Users:', req.query.SELECT.columns);
        
    });

//   const { Users } = this.entities;  
});