tableextension 60106 "Resource Ext" extends Resource
{
    fields
    {
        field(60100; Rental; Boolean)
        {
            Caption = 'Rental';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                testfield(Type, Type::Machine);
            end;
        }
        field(60165; "Fixed Asset No."; code[20])
        {
            Caption = 'Fixed Asset No.';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset" where(rental=const(true));
        }
        field(60170; Freight; Boolean)
        {
            Caption = 'Fixed Asset No.';
            DataClassification = ToBeClassified;
        }
        modify(Type)
        {
        trigger OnAfterValidate()
        begin
            IF Type = Type::Person then begin
                Rental:=false;
            end;
        end;
        }
        modify("Resource Group No.")
        {
        trigger OnAfterValidate()
        begin
            If ResGrp.get("Resource Group No.")then Rental:=ResGrp.Rental;
        end;
        }
    }
    var ResGrp: record "Resource Group";
}
