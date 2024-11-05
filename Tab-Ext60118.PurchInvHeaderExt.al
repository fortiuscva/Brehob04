tableextension 60118 "Purch. Inv. Header Ext" extends "Purch. Inv. Header"
{
    fields
    {
        field(60100; "Ship-to Phone No."; Text[30])
        {
            Caption = 'Ship-to Phone No.';
            DataClassification = ToBeClassified;
        }
        field(60110; "Shipping Agent Code"; code[10])
        {
            Caption = 'Shipping Agent Code';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                If ShipAgent.get("Shipping Agent Code")then "Shipping Agent Account No.":=ShipAgent."Account No.";
            end;
        }
        field(60120; "Shipping Agent Account No."; text[30])
        {
            Caption = 'Shipping Agent Account No.';
            DataClassification = ToBeClassified;
        }
    }
    var ShipAgent: record "Shipping Agent";
}
