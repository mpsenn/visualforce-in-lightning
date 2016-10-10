# shopping-cart
A simple Shopping Cart implemented in Visualforce and Apex

This demo content was intended to give developers the tools to step-by-step update Visualforce pages to use Lightning components. The Lightning platform can provide advanced client functionality, and fits into the modern web better than Visualforce ever has.

Visualforce is still an important part of the Salesforce platform, and existing Visualforce code will continue to be supported.

The step-by-step process outlined in the demo was:

1\. Add Lightning dependencies to a Lightning app that extends from "ltng:outApp". These dependencies can be standard or custom components and events.

    <aura:application access="GLOBAL" extends="ltng:outApp" >
        <aura:dependency resource="markup://c:StoreItem"/>
        <aura:dependency resource="markup://c:addToCart" type="EVENT"/>
    </aura:application>

2\. Initialize Lightning Out in your Visualforce markup.

    $Lightning.use("ftplatform:StoreDependencies", function() {
        // Do any work once Lightning loads
    });

3\. Create any Lightning components inside the $Lightning.use callback.

    $Lightning.createComponent(
        "ftplatform:StoreItem",
        {"recordId": productId},
        productDOM,
        function() {}
    );

## Files

Visualforce pages will be in [src/pages/](src/pages) directory. See [Store.page](src/pages/Store.page) and [Store_LightningOut.page](src/pages/Store_LightningOut.page) for the content we demonstrated during the presentation.

The other Visualforce pages and the static resources are from a demo session earlier in Dreamforce.

Lightning components and events created are in [src/aura/](src/aura) directory. [StoreItem](src/aura/StoreItem) is the main Lightning component. See the [.cmp](src/aura/StoreItem/StoreItem.cmp) and [.js](src/aura/StoreItem/StoreItemController.js) files for the Lightning markup and client controller code.

The Lightning Dependencies app is called [StoreDependencies](src/aura/StoreDependencies).

## Links

I found these links very helpful when developing the demo content.

* [Lightning Components Basics](https://trailhead.salesforce.com/en/module/lex_dev_lc_basics) Trailhead module
* [Visualforce & Lightning Experience](https://trailhead.salesforce.com/en/module/lex_dev_visualforce) Trailhead module
* [Lightning Design System](https://www.lightningdesignsystem.com/components/cards/) cards example
* [Lightning Out](https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/lightning_out.htm) in the Developer Guide
