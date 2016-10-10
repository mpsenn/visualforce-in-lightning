.store-form {
	font-size: 1.5em;
	display: flex;
}
div.items-panel {
	width: 1024px;
	margin-left: 1em;
}

span.items {
	margin: auto;
	display: flex;
	flex-wrap: wrap;
}
.item, .cart-item {
    display : block;
}

.item {
    padding: 1em;
    border: 1px solid grey;
    margin: 1em;
    align-items: stretch;
    height: 200px;
    width: 200px;
    position: relative;
    background-color: #e7c6e1;
}

div.item-lightning-out {
    display: inline-block;
    margin: 1em;
    align-items: stretch;
    position: relative;
}

.item-attr {
    display: block;
    margin:  0.5em;
}

.name {
	font-size: 1.5em;
	font-weight: bold;
}

.desc, .price {
	padding-left: 0.5em;
}

label {
    margin-right: 1em;
}

.personal-data {
    padding: 0.5em;
}

.header, .order, .footer {
    display: block;
    padding: 0.5em;
}

.empty-message {
    font-style: italic;
}

span.add-to-cart {
	align-self: flex-end;
	display: none;
	position: absolute;
	right: 5px;
	bottom: 5px;
}

.cart-status {
	font-style: italic;
	font-size: 2em;
	padding: 1em 0 1em 0;
}

.cart {
	flex: 0 0 150px;
}

.checkout-form, .order-summary {
	font-size: 1.5em;
}