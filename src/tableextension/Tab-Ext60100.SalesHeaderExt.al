tableextension 60100 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(60100; "Job No."; Code[20])
        {
            Caption = 'Project No.';
            Editable = false;
            TableRelation = Job;
            FieldClass = FlowField;
            //CalcFormula = Lookup(Job."No." WHERE("Bill-to Customer No." = FIELD("Bill-to Customer No."),
            //"Ship-to Code" = FIELD("Ship-to Code"), "Location Code" = FIELD("Location Code")));
            //CalcFormula = Lookup(Job."No." WHERE("Bill-to Customer No."=FIELD("Bill-to Customer No."), "Ship-to Code"=FIELD("Ship-to Code"), "Loc Code Temp"=FIELD("Location Code")));
            CalcFormula = lookup("Sales Line"."Job No." where("Document Type"=field("Document Type"), "Document No."=field("No."), "Job No."=filter(<>''))); //2024-09-11
        }
        field(60110; "Job Required"; boolean)
        {
            caption = 'Project Required';
            DataClassification = ToBeClassified;
        }
        field(60120; "Job Type";enum "Job Type")
        {
            caption = 'Project Type';
            DataClassification = ToBeClassified;
        }
        field(60130; "P.O. Required"; Boolean)
        {
            Caption = 'P.O. Required';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60140; "Completion Date"; date)
        {
            caption = 'Completion Date';
            DataClassification = ToBeClassified;
        }
        modify("Sell-to Customer No.")
        {
        trigger OnBeforeValidate()
        begin
            If Cust.get("Sell-to Customer No.")then "P.O. Required":=Cust."P.O. Required";
        end;
        }
    }
    var Cust: record Customer;
}
