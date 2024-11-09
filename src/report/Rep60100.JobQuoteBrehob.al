report 60100 "Job Quote - Brehob"
{
    DefaultRenderingLayout = "JobQuoteBH.rdlc";
    Caption = 'Project Quote - Brehob';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Job; Job)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Planning Date Filter";

            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyAddress7; CompanyAddr[7])
            {
            }
            column(CompanyAddress8; CompanyAddr[8])
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(JobtableCaptJobFilter; TableCaption + ': ' + JobFilter)
            {
            }
            column(JobFilter; JobFilter)
            {
            }
            column(JobTasktableCaptFilter; "Job Task".TableCaption + ': ' + JobTaskFilter)
            {
            }
            column(JobTaskFilter; JobTaskFilter)
            {
            }
            column(No_Job; "No.")
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(JobQuoteCaptLbl; JobQuoteCaptLbl)
            {
            }
            column(BillToAddress1; BillToAddr[1])
            {
            }
            column(BillToAddress2; BillToAddr[2])
            {
            }
            column(BillToAddress3; BillToAddr[3])
            {
            }
            column(BillToAddress4; BillToAddr[4])
            {
            }
            column(BillToAddress5; BillToAddr[5])
            {
            }
            column(BillToAddress6; BillToAddr[6])
            {
            }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }
            column(PaymentTermsDesc; PaymentTermsDesc)
            {
            }
            column(ExternalDocumentNo; Job."External Document No.")
            {
            }
            dataitem("Job Task"; "Job Task")
            {
                DataItemLink = "Job No." = field("No.");
                DataItemTableView = sorting("Job No.", "Job Task No.");
                PrintOnlyIfDetail = true;

                column(JobTaskNo_JobTask; HeaderJobTaskNo)
                {
                }
                column(Indentation_JobTask; HeaderJobTask)
                {
                }
                column(NewTaskGroup; NewTaskGroup)
                {
                }
                column(QuantityCaption; QuantityLbl)
                {
                }
                column(UnitPriceCaption; UnitPriceLbl)
                {
                }
                column(TotalPriceCaption; TotalPriceLbl)
                {
                }
                column(JobTaskTypeCaption; JobTaskTypeLbl)
                {
                }
                column(NoCaption; NoLbl)
                {
                }
                column(Description_Job; Job.Description)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(JobTaskNoCapt; JobTaskNoCaptLbl)
                {
                }
                column(TotalJobTask; TotalJobTask)
                {
                }
                column(TotalJob; TotalJob)
                {
                }
                dataitem("Job Planning Line"; "Job Planning Line")
                {
                    DataItemLink = "Job No." = field("Job No."), "Job Task No." = field("Job Task No.");
                    DataItemTableView = sorting("Job No.", "Job Task No.", "Line No.");
                    RequestFilterFields = "Job Task No.";

                    column(ShowIntBody1; "Job Task"."Job Task Type" in ["Job Task"."Job Task Type"::Heading, "Job Task"."Job Task Type"::"Begin-Total"])
                    {
                    }
                    column(Quantity; Quantity)
                    {
                    }
                    column(UnitPriceLCY; "Unit Price (LCY)")
                    {
                    }
                    column(UnitPrice; "Unit Price")
                    {
                    }
                    column(TotalPriceLCY; "Total Price (LCY)")
                    {
                        AutoFormatExpression = CurrencyFormat;
                        AutoFormatType = 10;
                    }
                    column(TotalPrice; "Total Price")
                    {
                    }
                    column(Type; Type)
                    {
                    }
                    column(Number; "No.")
                    {
                    }
                    column(JobPlanningLine_JobTaskNo; "Job Task No.")
                    {
                    }
                    column(JobPlanningLine_Type; Type)
                    {
                    }
                    column(JobPlanningLine_LineType; "Line Type")
                    {
                    }
                    column(Indentation_JobTask2; PadStr('', 2 * "Job Task".Indentation) + Description)
                    {
                    }
                    column(Indentation_JobTaskTotal; PadStr('', 2 * "Job Task".Indentation) + Description)
                    {
                    }
                    column(ShowIntBody2; "Job Task"."Job Task Type" in ["Job Task"."Job Task Type"::Total, "Job Task"."Job Task Type"::"End-Total"])
                    {
                    }
                    column(ShowIntBody3; ("Job Task"."Job Task Type" in ["Job Task"."Job Task Type"::Posting]) and PrintSection)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        PrintSection := true;
                        if "Line Type" = "Line Type"::Budget then begin
                            PrintSection := false;
                            CurrReport.Skip();
                        end;
                        JobTotalValue += ("Unit Price" * Quantity);
                        if FirstLineHasBeenOutput then Clear(CompanyInfo.Picture);
                        FirstLineHasBeenOutput := true;
                        ConstructCurrencyFormatString();
                    end;

                    trigger OnPreDataItem()
                    begin
                        CompanyInfo.CalcFields(Picture);
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    if "Job Task Type" = "Job Task Type"::"Begin-Total" then begin
                        if Indentation = 0 then TotalJob := TotalLbl + ' ' + Description;
                        HeaderJobTask := PadStr('', 2 * Indentation) + Description;
                        HeaderJobTaskNo := Format("Job Task No.");
                        TotalJobTask := PadStr('', 2 * Indentation) + TotalLbl + ' ' + Description;
                    end;
                    if ((CurrentIndentation > 0) and (CurrentIndentation < Indentation)) or ("Job Task Type" = "Job Task Type"::"End-Total") then NewTaskGroup := NewTaskGroup + 1;
                    CurrentIndentation := Indentation;
                end;

                trigger OnPreDataItem()
                begin
                    CompanyInfo.CalcFields(Picture);
                end;
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));

                column(JobTotalValue; JobTotalValue)
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                PaymentTerms: Record "Payment Terms";
            begin
                JobTotalValue := 0;
                NewTaskGroup := 0;
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                FormatAddr.JobBillTo(BillToAddr, Job);
                FormatAddr_JobShipTo(ShipToAddr, Job);
                Clear(PaymentTermsDesc);
                if PaymentTerms.Get(Job."Payment Terms Code") then begin
                    PaymentTermsDesc := PaymentTerms.Description;
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
            }
        }
        actions
        {
        }
    }
    rendering
    {
        layout("JobQuoteBH.rdlc")
        {
            Type = RDLC;
            LayoutFile = './Local/JobQuoteBH.rdlc';
            Caption = 'Project Quote (RDLC)';
            Summary = 'The Project Quote (RDLC) provides a detailed layout.';
        }
    }
    labels
    {
        JobNoLbl = 'Project No.';
        JobDescriptionLbl = 'Description';
        ExternalDocNoLbl = 'External Document No.:';
        PaymentTermsLbl = 'Payment Terms:';
        BillToLbl = 'BILL TO';
        ShipToLbl = 'SHIP TO';
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        JobsSetup.Get();
        ConstructCurrencyFormatString();
    end;

    trigger OnPreReport()
    begin
        JobFilter := Job.GetFilters();
        JobTaskFilter := "Job Planning Line".GetFilters();
        CompanyLogoPosition := JobsSetup."Logo Position on Documents";
    end;

    local procedure ConstructCurrencyFormatString()
    var
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        CurrencySymbol: Text[10];
        CurrencyLbl: Label '%1<precision, 2:2><standard format, 0>', Comment = '%1=CurrencySymbol';
    begin
        if Job."Currency Code" = '' then begin
            GLSetup.Get();
            CurrencySymbol := GLSetup.GetCurrencySymbol();
        end
        else begin
            if Currency.Get(Job."Currency Code") then;
            CurrencySymbol := Currency.GetCurrencySymbol();
        end;
        CurrencyFormat := StrSubstNo(CurrencyLbl, CurrencySymbol);
    end;

    local procedure FormatAddr_JobShipTo(var AddrArray: array[8] of Text[100]; var Job: Record Job)
    begin
        FormatAddr.FormatAddr(AddrArray, Job."Ship-to Name", Job."Ship-to Name 2", Job."Ship-to Contact", Job."Ship-to Address", Job."Ship-to Address 2", Job."Ship-to City", Job."Ship-to Post Code", Job."Ship-to County", Job."Ship-to Country/Region Code");
    end;

    var
        JobsSetup: Record "Jobs Setup";
        FormatAddr: Codeunit "Format Address";
        JobFilter: Text;
        JobTaskFilter: Text;
        FirstLineHasBeenOutput: Boolean;
        PrintSection: Boolean;
        CurrReportPageNoCaptionLbl: Label 'Page';
        JobQuoteCaptLbl: Label 'Project Quote';
        DescriptionCaptionLbl: Label 'Description';
        JobTaskNoCaptLbl: Label 'Project Task No.';
        QuantityLbl: Label 'Quantity';
        UnitPriceLbl: Label 'Unit Price';
        TotalPriceLbl: Label 'Total Price';
        JobTaskTypeLbl: Label 'Project Task Type';
        NoLbl: Label 'No.';
        NewTaskGroup: Integer;
        CurrentIndentation: Integer;
        TotalLbl: Label 'Total';
        CompanyLogoPosition: Integer;
        JobTotalValue: Decimal;
        CompanyAddr: array[8] of Text[100];
        BillToAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        TotalJobTask: Text[250];
        TotalJob: Text[250];
        HeaderJobTaskNo: Text[250];
        HeaderJobTask: Text[250];
        CurrencyFormat: Text;
        PaymentTermsDesc: Text;

    protected var
        CompanyInfo: Record "Company Information";
}
