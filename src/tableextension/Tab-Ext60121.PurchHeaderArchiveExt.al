tableextension 60121 "Purch Header Archive Ext" extends "Purchase Header Archive"
{
    fields
    {
        field(60100; "Ship-to Phone No."; Text[30])
        {
            Caption = 'Ship-to Phone No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60101; "BHB Ship-to Phone No."; Text[30])
        {
            Caption = 'BHB Ship-to Phone No.';
            DataClassification = ToBeClassified;
        }
        field(60110; "Shipping Agent Code"; code[10])
        {
            Caption = 'Shipping Agent Code';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
            Editable = false;
        }
        field(60120; "Shipping Agent Account No."; text[30])
        {
            Caption = 'Shipping Agent Account No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    var
        ShipAgent: record "Shipping Agent";
}
