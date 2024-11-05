report 60101 "Load Fields"
{
    ApplicationArea = All;
    Caption = 'Load Fields';
    UsageCategory = Administration;
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(Field; "Field")
        {
            trigger OnPreDataItem()
            begin
                Field3.deleteall;
            end;
            trigger OnAfterGetRecord()
            begin
                Field3.init;
                Field3."Table No.":=TableNo;
                Field3."No.":="No.";
                Field3."Table Name":=TableName;
                Field3."Field Name":=FieldName;
                //Field3.Type := Type;
                case Type OF Field.Type::TableFilter: begin
                    Field3.Type:=Field3.Type::TableFilter;
                end;
                Field.Type::RecordID: begin
                    Field3.Type:=Field3.Type::RecordID;
                end;
                Field.Type::OemText: begin
                    Field3.Type:=Field3.Type::OemText;
                end;
                Field.Type::Date: begin
                    Field3.Type:=Field3.Type::Date;
                end;
                Field.Type::Time: begin
                    Field3.Type:=Field3.Type::Time;
                end;
                Field.Type::DateFormula: begin
                    Field3.Type:=Field3.Type::DateFormula;
                end;
                Field.Type::Decimal: begin
                    Field3.Type:=Field3.Type::Decimal;
                end;
                Field.Type::Media: begin
                    Field3.Type:=Field3.Type::Media;
                end;
                Field.Type::MediaSet: begin
                    Field3.Type:=Field3.Type::MediaSet;
                end;
                Field.Type::Text: begin
                    Field3.Type:=Field3.Type::Text;
                end;
                Field.Type::Code: begin
                    Field3.Type:=Field3.Type::Code;
                end;
                Field.Type::Binary: begin
                    Field3.Type:=Field3.Type::Binary;
                end;
                Field.Type::BLOB: begin
                    Field3.Type:=Field3.Type::BLOB;
                end;
                Field.Type::Boolean: begin
                    Field3.Type:=Field3.Type::Boolean;
                end;
                Field.Type::Integer: begin
                    Field3.Type:=Field3.Type::Integer;
                end;
                Field.Type::OemCode: begin
                    Field3.Type:=Field3.Type::OemCode;
                end;
                Field.Type::Option: begin
                    Field3.Type:=Field3.Type::Option;
                end;
                Field.Type::BigInteger: begin
                    Field3.Type:=Field3.Type::BigInteger;
                end;
                Field.Type::Duration: begin
                    Field3.Type:=Field3.Type::Duration;
                end;
                Field.Type::GUID: begin
                    Field3.Type:=Field3.Type::GUID;
                end;
                Field.Type::DateTime: begin
                    Field3.Type:=Field3.Type::DateTime;
                end;
                end;
                Field3.Length:=Len;
                Field3.Class:=Class;
                Field3.Enabled:=Enabled;
                Field3."Type Name":="Type Name";
                Field3."Field Caption":="Field Caption";
                Field3."Relation Table No.":=RelationTableNo;
                Field3."Relation Field No.":=RelationFieldNo;
                Field3."SQL Data Type":=SQLDataType;
                Field3."Option String":=OptionString;
                Field3."Obsolete State":=ObsoleteState;
                Field3."Obsolete Reason":=ObsoleteReason;
                Field3."Data Classification":=DataClassification;
                Field3."Is Part Of Primary Key":=IsPartOfPrimaryKey;
                Field3."App Package ID":="App Package ID";
                Field3."App Runtime Package ID":="App Runtime Package ID";
                Field3.insert;
            end;
        }
    }
    var Field3: record "Fields 3";
    trigger OnPostReport()
    begin
        //message('Done');
        page.run(50133);
    end;
}
