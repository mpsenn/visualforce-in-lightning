public class StoreExtension {
    private ApexPages.StandardController controller;
    public StoreExtension() {
        showCart = false;
    }

    public StoreExtension(ApexPages.StandardController controller) {
         this.controller = controller;
         showCart = false;
    } 
    
    //
    // Properties (used on the VF pages)
    //    
    
    public Boolean showCart { get; set; }
    public List<Item__c> items { 
        get {
            if (items == null) {
                items = [select Name, Description__c, Price__c from Item__c where Is_Active__c = true];
            }
            return items;
        }
        set; 
    }
    
    @AuraEnabled
    public static Item__c getItemById(String recordId) {
        Item__c item = [select Name, Description__c, Price__c from Item__c
                where Is_Active__c = true
                and Id = :recordId];
        return item;
    }

    public Order__c theOrder { 
        get {
            if (theOrder == null) {
                theOrder = (Order__c)controller.getRecord();
                if (theOrder.Id == null) {
                    theOrder.Total__c = 0;
                } else {
                     refreshOrder();
                }
            }
            return theOrder;
        }
        set; 
    }

    //
    // Actions (used by the VF pages)
    //  
    public void addToCart() {
        String itemId = getParam('itemId');
        Item__c item = [select Price__c from Item__c where Id = :itemId];

        // create the lineItem, or update the quantity
        createOrUpdateLineItem(itemId);
        
        // Update the total
        theOrder.Total__c = theOrder.Total__c + item.Price__c;
        updateAndRefreshOrder();
    }

    public String getToggleLink() {
        return (showCart ? 'Hide Cart' : 'Show Cart');
    }
    
    public void toggleShowCart() {
        showCart = !showCart;
    }
    
    public PageReference gotoCheckout() {
        return Page.Checkout;
    }
    
    public PageReference completeOrder() {
        return Page.OrderSummary;
    }

    public PageReference continueShopping() {
        return getStorePage();
    }

    public PageReference getStorePage() {
        return Page.Store;
    }
    
    //
    // Helpers
    //
    /**
     *  Returns a parameter from the paramater map for this request
     */
    private String getParam(String key) {
        return ApexPages.currentPage().getParameters().get(key);
    }
    
    /**
     *  Get an existing line item, updating the quantity.
     *  OR, create a new line item with quantity 1.
     */
    private void createOrUpdateLineItem(Id itemId) {
        if (theOrder.Id == null) {
            insert theOrder;
        }
        Line_Item__c li = getExistingLineItem(itemId);
        if (li == null) {
            li = new Line_Item__c(Quantity__c = 1, Item__c = itemId, Order__c = theOrder.Id);
        } else {
            li.Quantity__c++;
        }
        upsert li;
    }
    
    /**
     *  Look for an existing line item for this item.
     *  May return null if none exists yet.
     */
    private Line_Item__c getExistingLineItem(Id itemId) {
        Line_Item__c li = null;
        for (Line_Item__c lineItem : theOrder.Line_Items__r) {
            if (lineItem.Item__c.equals(itemId)) {
                return lineItem;
            }
        }
        return null;
    }
    
    /**
     *  Refreshes the order from the DB, pulling in the fields used
     *  on the VF pages.
     */
    private void refreshOrder() {
        // Refresh existing orders
        theOrder = [select Total__c, Name__c, Email__c, lastModifiedDate, (select Name, 
            Quantity__c, 
            Item__r.Name, 
            Item__r.Description__c, 
            Item__r.Price__c from Line_Items__r) from Order__c where Id = :theOrder.Id];
    }
    
    /**
     *  Upserts and refreshes the order from the DB.
     */
    private void updateAndRefreshOrder() {
        update theOrder;
        refreshOrder();
    }
}