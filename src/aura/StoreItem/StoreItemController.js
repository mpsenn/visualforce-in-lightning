({
    doInit : function(component, event, helper) {
        var recordId = component.get("v.recordId");
                
        // Create the action
        var action = component.get("c.getItemById");
        action.setParams({
            "recordId":  recordId
        });
        
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state == "SUCCESS") {
                component.set("v.product", response.getReturnValue());
            }
            else {
                console.log("Data load failed with state: ", state);
                console.log("response: ", response);
            }
        });
        
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    onAddToCardClick: function(component, event, helper) {
        var recordId = component.get("v.recordId");
        
        var vfEvent = $A.getEvt("c:addToCart");
        vfEvent.setParams({ "productId": recordId });
        
        vfEvent.fire();
        console.log("Fired click event!", vfEvent);
    }
})