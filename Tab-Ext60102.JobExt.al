tableextension 60102 "Job Ext" extends Job
{
    fields
    {
        field(60100; "Loc Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = location;
        //ObsoleteState = removed;
        //ObsoleteReason = 'Becomes part of base app in release 24.x';
        }
        field(60101; "Loc Code Temp"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = location;
        }
        field(60110; "Work Description"; BLOB)
        {
            Caption = 'Work Description';
            DataClassification = ToBeClassified;
        }
        field(60120; "Ready To Invoice"; boolean)
        {
            Caption = 'Ready To Invoice';
            DataClassification = ToBeClassified;
        }
        field(60130; "Priority Level";enum "Priortity Level")
        {
            Caption = 'Priority Level';
            DataClassification = ToBeClassified;
        }
        field(60140; "Field Service"; boolean)
        {
            Caption = 'Field Service';
            DataClassification = ToBeClassified;
        }
        field(60150; "P.O. Required"; Boolean)
        {
            Caption = 'P.O. Required';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60160; "Salesperson Code"; code[10])
        {
            Caption = 'P.O. Required';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(60170; "Completion Date"; date)
        {
            Caption = 'Completion Date';
            Editable = false;
            FieldClass = flowfield;
            CalcFormula = max("Job Planning Line"."Planning Date" where("Job No."=field("No.")));
        }
        modify("Bill-to Customer No.")
        {
        trigger OnBeforeValidate()
        begin
            If Cust.get("Bill-to Customer No.")then begin
                "P.O. Required":=Cust."P.O. Required";
                "Salesperson Code":=Cust."Salesperson Code";
            end;
        end;
        }
    }
    var Cust: record Customer;
    procedure SetWorkDescription(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Work Description");
        "Work Description".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;
    procedure GetWorkDescription()WorkDescription: Text var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Work Description");
        "Work Description".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Work Description")));
    end;
}
