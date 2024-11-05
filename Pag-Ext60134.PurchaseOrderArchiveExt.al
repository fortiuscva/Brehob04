pageextension 60134 "Purchase Order Archive Ext" extends "Purchase Order Archive"
{
    layout
    {
        addafter("Document Date")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
                Caption = 'Your Reference';
            }
        }
    }
}
