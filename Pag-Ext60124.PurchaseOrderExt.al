pageextension 60124 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Ship-to Contact")
        {
            field("Ship-to Phone No."; rec."Ship-to Phone No.")
            {
                ApplicationArea = all;
                caption = 'Phone No.';
                ToolTip = 'Specifies the phone number of a contact person for the address of the address that you want the items on the purchase document to be shipped to.';
                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                Importance = Additional;
            }
        }
        addafter("Shipment Method Code")
        {
            field("Shipping Agent Code"; rec."Shipping Agent Code")
            {
                ApplicationArea = all;
                caption = 'Shipping Agent Code';
                ToolTip = 'Specifies the shipping agent to be used on the purchase document.';
                Importance = Additional;
            }
            field("Shipping Agent Account No."; rec."Shipping Agent Account No.")
            {
                ApplicationArea = all;
                caption = 'Shipping Agent Account No.';
                ToolTip = 'Specifies the account number of the shipping agent to be used on the purchase document.';
                Importance = Additional;
            }
        }
    }
}
