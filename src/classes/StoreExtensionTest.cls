@isTest
private class StoreExtensionTest {
	
	@isTest static void testAddToCart() {
		Item__c item = new Item__c(Name = 'Test Item', Price__c = 10, Is_Active__c = true);
		insert item;

		Order__c order = new Order__c(Total__c = 0);
		insert order;

		ApexPages.currentPage().getParameters().put('itemId', item.Id);

		StoreExtension se = new StoreExtension(new ApexPages.StandardController(order));

		// Get the items
		System.assert(se.items.size() == 1);

		// Add to Cart
		se.addtoCart();
		System.assert(order.Total__c == 10);
	}
	
	@isTest static void testHelperMethods() {
		StoreExtension se = new StoreExtension();

		se.toggleShowCart();
		System.assert(se.showCart);
		System.assert(se.getToggleLink().equals('Hide Cart'));

		System.assert(se.gotoCheckout().getUrl() == Page.Checkout.getUrl(), se.gotoCheckout());
		System.assert(se.continueShopping().getUrl() == Page.Store.getUrl(), se.continueShopping());
		System.assert(se.completeOrder().getUrl() == Page.OrderSummary.getUrl(), se.completeOrder());
	}
}