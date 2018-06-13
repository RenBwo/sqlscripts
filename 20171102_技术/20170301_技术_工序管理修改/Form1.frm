VERSION 5.00
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Begin VB.Form Frm_main 
   Caption         =   "Frm_main"
   ClientHeight    =   10260
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   18960
   LinkTopic       =   "Form1"
   ScaleHeight     =   10260
   ScaleWidth      =   18960
   StartUpPosition =   3  '窗口缺省
   Begin MSDataGridLib.DataGrid DataGrid3 
      Height          =   2500
      Left            =   480
      TabIndex        =   13
      Top             =   6840
      Width           =   16575
      _ExtentX        =   29236
      _ExtentY        =   4419
      _Version        =   393216
      AllowUpdate     =   -1  'True
      HeadLines       =   4
      RowHeight       =   17
      FormatLocked    =   -1  'True
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Caption         =   "计件工资查询表"
      ColumnCount     =   18
      BeginProperty Column00 
         DataField       =   "计件工资单据编号"
         Caption         =   "计件工资单据编号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   "工作令号"
         Caption         =   "工作令号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column02 
         DataField       =   "产品长代码"
         Caption         =   "物料长代码"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column03 
         DataField       =   "产品名称"
         Caption         =   "物料名称"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column04 
         DataField       =   "工序汇报中工资系数"
         Caption         =   "工序汇报中工资系数"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column05 
         DataField       =   "工序汇报中工件数量"
         Caption         =   "工序汇报中工件数量"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column06 
         DataField       =   "计件工资中工资系数"
         Caption         =   "计件工资中工资系数"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column07 
         DataField       =   "计件工资中的工件数量"
         Caption         =   "计件工资中的工件数量"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column08 
         DataField       =   "工序汇报单据编号"
         Caption         =   "工序汇报单据编号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column09 
         DataField       =   "加工数量"
         Caption         =   "加工数量"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column10 
         DataField       =   "单位计件工资"
         Caption         =   "单位计件工资"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.00000000"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column11 
         DataField       =   "计件工资合计"
         Caption         =   "计件工资合计"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column12 
         DataField       =   "实际计件工资合计"
         Caption         =   "实际计件工资合计"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column13 
         DataField       =   "计件工资清单中总工资"
         Caption         =   "计件工资清单中总工资"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column14 
         DataField       =   "实际总工资"
         Caption         =   "实际总工资"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column15 
         DataField       =   "工序名称"
         Caption         =   "工序名称"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column16 
         DataField       =   "日期"
         Caption         =   "日期"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   "yyyy-M-d"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column17 
         DataField       =   "工序计划单编号"
         Caption         =   "工序计划单编号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
            Alignment       =   2
            ColumnWidth     =   1110.047
         EndProperty
         BeginProperty Column01 
            Alignment       =   2
            ColumnWidth     =   1305.071
         EndProperty
         BeginProperty Column02 
         EndProperty
         BeginProperty Column03 
         EndProperty
         BeginProperty Column04 
            Alignment       =   2
            ColumnWidth     =   720
         EndProperty
         BeginProperty Column05 
            Alignment       =   2
            ColumnWidth     =   720
         EndProperty
         BeginProperty Column06 
            Alignment       =   2
            ColumnWidth     =   734.74
         EndProperty
         BeginProperty Column07 
            Alignment       =   2
            ColumnWidth     =   824.882
         EndProperty
         BeginProperty Column08 
            Alignment       =   2
            ColumnWidth     =   1200.189
         EndProperty
         BeginProperty Column09 
            Alignment       =   2
            ColumnWidth     =   854.929
         EndProperty
         BeginProperty Column10 
            Alignment       =   2
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column11 
            Alignment       =   2
            ColumnWidth     =   840.189
         EndProperty
         BeginProperty Column12 
            Alignment       =   2
            ColumnWidth     =   840.189
         EndProperty
         BeginProperty Column13 
            Alignment       =   2
            ColumnWidth     =   975.118
         EndProperty
         BeginProperty Column14 
            Alignment       =   2
            ColumnWidth     =   764.787
         EndProperty
         BeginProperty Column15 
            Alignment       =   2
            ColumnWidth     =   1335.118
         EndProperty
         BeginProperty Column16 
            Alignment       =   2
            ColumnWidth     =   1214.929
         EndProperty
         BeginProperty Column17 
            Alignment       =   2
            ColumnWidth     =   1154.835
         EndProperty
      EndProperty
   End
   Begin MSDataGridLib.DataGrid DataGrid2 
      Height          =   2475
      Left            =   480
      TabIndex        =   12
      Top             =   4320
      Width           =   16575
      _ExtentX        =   29236
      _ExtentY        =   4366
      _Version        =   393216
      AllowUpdate     =   -1  'True
      HeadLines       =   2
      RowHeight       =   17
      FormatLocked    =   -1  'True
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Caption         =   "工序汇报查询表"
      ColumnCount     =   9
      BeginProperty Column00 
         DataField       =   "工序汇报编号"
         Caption         =   "工序汇报编号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   "工作令号"
         Caption         =   "工作令号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column02 
         DataField       =   "产品长代码"
         Caption         =   "物料长代码"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column03 
         DataField       =   "产品名称"
         Caption         =   "物料名称"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column04 
         DataField       =   "工序计划单工资系数"
         Caption         =   "工序计划单工资系数"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.000000"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column05 
         DataField       =   "工序汇报工资系数"
         Caption         =   "工序汇报工资系数"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.000000"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column06 
         DataField       =   "工序计划单工件数量"
         Caption         =   "工序计划单工件数量"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column07 
         DataField       =   "工序汇报工件数量"
         Caption         =   "工序汇报工件数量"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.0000"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column08 
         DataField       =   "工序名称"
         Caption         =   "工序名称"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
         EndProperty
         BeginProperty Column01 
         EndProperty
         BeginProperty Column02 
         EndProperty
         BeginProperty Column03 
         EndProperty
         BeginProperty Column04 
            ColumnWidth     =   1725.165
         EndProperty
         BeginProperty Column05 
            ColumnWidth     =   1814.74
         EndProperty
         BeginProperty Column06 
            ColumnWidth     =   1785.26
         EndProperty
         BeginProperty Column07 
         EndProperty
         BeginProperty Column08 
         EndProperty
      EndProperty
   End
   Begin MSDataGridLib.DataGrid DataGrid1 
      Height          =   2700
      Left            =   480
      TabIndex        =   5
      Top             =   1560
      Width           =   16575
      _ExtentX        =   29236
      _ExtentY        =   4763
      _Version        =   393216
      AllowUpdate     =   -1  'True
      HeadLines       =   4
      RowHeight       =   19
      RowDividerStyle =   1
      FormatLocked    =   -1  'True
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "宋体"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Caption         =   "工序计划单查询表"
      ColumnCount     =   14
      BeginProperty Column00 
         DataField       =   "工作令号"
         Caption         =   "工作令号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   "产品长代码"
         Caption         =   "产品长代码"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column02 
         DataField       =   "产品名称"
         Caption         =   "产品名称"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column03 
         DataField       =   "工艺路线工资系数"
         Caption         =   "工艺路线工资系数"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column04 
         DataField       =   "工艺路线工件数量"
         Caption         =   "工艺路线工件数量"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column05 
         DataField       =   "工艺路线单位计件工资"
         Caption         =   "工艺路线单位计件工资"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.00000000"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column06 
         DataField       =   "工序计划单工资系数"
         Caption         =   "工序计划单工资系数"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column07 
         DataField       =   "工序计划单工件数量"
         Caption         =   "工序计划单工件数量"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column08 
         DataField       =   "工序计划单单位计件工资"
         Caption         =   "工序计划单单位计件工资"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.00000000"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column09 
         DataField       =   "工序计划单号"
         Caption         =   "工序计划单号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column10 
         DataField       =   "工序计划单工序名称"
         Caption         =   "工序计划单工序名称"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column11 
         DataField       =   "工序计划单中工序号"
         Caption         =   "工序计划单中工序号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column12 
         DataField       =   "工艺路线编号"
         Caption         =   "工艺路线编号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column13 
         DataField       =   "工艺路线工序号"
         Caption         =   "工艺路线工序号"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   2052
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
            Alignment       =   2
            ColumnWidth     =   1065.26
         EndProperty
         BeginProperty Column01 
            Alignment       =   2
            ColumnWidth     =   1695.118
         EndProperty
         BeginProperty Column02 
            Alignment       =   2
            ColumnWidth     =   2055.118
         EndProperty
         BeginProperty Column03 
            Alignment       =   2
            ColumnWidth     =   629.858
         EndProperty
         BeginProperty Column04 
            Alignment       =   2
            ColumnWidth     =   705.26
         EndProperty
         BeginProperty Column05 
            Alignment       =   2
            ColumnWidth     =   1110.047
         EndProperty
         BeginProperty Column06 
            Alignment       =   2
            ColumnWidth     =   659.906
         EndProperty
         BeginProperty Column07 
            Alignment       =   2
            ColumnWidth     =   720
         EndProperty
         BeginProperty Column08 
            Alignment       =   2
            ColumnWidth     =   1244.976
         EndProperty
         BeginProperty Column09 
            Alignment       =   2
            ColumnWidth     =   1154.835
         EndProperty
         BeginProperty Column10 
            Alignment       =   2
            ColumnWidth     =   1709.858
         EndProperty
         BeginProperty Column11 
            Alignment       =   2
            ColumnWidth     =   659.906
         EndProperty
         BeginProperty Column12 
            Alignment       =   2
            ColumnWidth     =   1200.189
         EndProperty
         BeginProperty Column13 
            Alignment       =   2
            ColumnWidth     =   734.74
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Caption         =   "工序条件"
      Height          =   1215
      Left            =   480
      TabIndex        =   0
      Top             =   240
      Width           =   12255
      Begin VB.TextBox Text_fnumber 
         Height          =   375
         Left            =   4200
         TabIndex        =   15
         Top             =   240
         Width           =   1455
      End
      Begin VB.CommandButton C_udpate3 
         Caption         =   "计件工资更新"
         Height          =   400
         Left            =   10200
         TabIndex        =   11
         Top             =   720
         Width           =   1725
      End
      Begin VB.CommandButton C_inquiry3 
         Caption         =   "计件工资查询"
         Height          =   400
         Left            =   10200
         TabIndex        =   10
         Top             =   240
         Width           =   1725
      End
      Begin VB.CommandButton C_update2 
         Caption         =   "工序汇报更新"
         Height          =   400
         Left            =   7920
         TabIndex        =   9
         Top             =   720
         Width           =   1725
      End
      Begin VB.CommandButton C_inquiry2 
         Caption         =   "工序汇报查询"
         Height          =   400
         Left            =   7920
         TabIndex        =   8
         Top             =   240
         Width           =   1725
      End
      Begin VB.ComboBox CMB_FQUFEN 
         Height          =   300
         ItemData        =   "Form1.frx":0000
         Left            =   1080
         List            =   "Form1.frx":000A
         TabIndex        =   6
         Top             =   720
         Width           =   1575
      End
      Begin VB.CommandButton C_update1 
         Caption         =   "工序计划单更新"
         Height          =   400
         Left            =   5880
         TabIndex        =   4
         Top             =   720
         Width           =   1725
      End
      Begin VB.CommandButton C_inquiry1 
         Caption         =   "工序计划单查询"
         Height          =   400
         Left            =   5880
         TabIndex        =   3
         Top             =   240
         Width           =   1725
      End
      Begin VB.TextBox T_fgzl 
         Height          =   375
         Left            =   1080
         TabIndex        =   1
         Top             =   240
         Width           =   1500
      End
      Begin VB.Label Label1 
         Caption         =   "物料代码"
         Height          =   375
         Left            =   3000
         TabIndex        =   14
         Top             =   240
         Width           =   975
      End
      Begin VB.Label Label3 
         Caption         =   "区分:"
         Height          =   255
         Left            =   480
         TabIndex        =   7
         Top             =   760
         Width           =   735
      End
      Begin VB.Label Label2 
         Caption         =   "工作令号:"
         Height          =   255
         Left            =   120
         TabIndex        =   2
         Top             =   360
         Width           =   1095
      End
   End
End
Attribute VB_Name = "Frm_main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub C_inquiry1_click()
Dim ReturnValue As Integer
Dim ErrStr1 As String

If IsNull(T_fgzl.Text) Or T_fgzl.Text = "" Then
fgzl = "%"
Else
fgzl = T_fgzl.Text
End If

If IsNull(Text_fnumber.Text) Or Text_fnumber.Text = "" Then
fnumber = "%"
Else
fnumber = Text_fnumber.Text + "%"
End If

If CMB_FQUFEN.ListIndex = -1 Then
        fqufen = "A"
    ElseIf CMB_FQUFEN.ListIndex = 0 Then
        fqufen = "A"
    ElseIf CMB_FQUFEN.ListIndex = 1 Then
        fqufen = "B"
    Else
        fqufen = "A"
    End If

Set conn = New ADODB.Connection
connstr = "provider=sqloledb.1;persist security info = true;server=DBSERV;database=AIS20091217151735;user id=sa;password=whyb2009"
conn.Open connstr

Set cmd = New ADODB.Command

Set cmd.ActiveConnection = conn
cmd.CommandTimeout = 0
cmd.CommandText = "SHWorkBill_update1"
cmd.CommandType = adCmdStoredProc
conn.CursorLocation = adUseClient

Set rs = New ADODB.Recordset

cmd.Parameters(1) = "A"         ' ---输入参数
cmd.Parameters(2) = fqufen      ' ---输入参数
cmd.Parameters(3) = fgzl        ' ---输入参数
cmd.Parameters(4) = fnumber     ' --- 输入参数
cmd.Parameters(5) = ""          ' --- 输出参数
          
Set rs = cmd.Execute()

Set DataGrid1.DataSource = rs
DataGrid1.Refresh

Set rs = Nothing
Set conn = Nothing

End Sub

Private Sub C_update1_click()
Dim ReturnValue As Integer
Dim ErrStr1 As String

If IsNull(T_fgzl.Text) Or T_fgzl.Text = "" Then
fgzl = "%"
Else
fgzl = T_fgzl.Text
End If

If IsNull(Text_fnumber.Text) Or Text_fnumber.Text = "" Then
fnumber = "%"
Else
fnumber = Text_fnumber.Text + "%"
End If

If MsgBox("确认更新工序计划单数据吗？", vbYesNo) <> vbYes Then Exit Sub

Set conn = New ADODB.Connection
connstr = "provider=sqloledb.1;persist security info = true;server=DBSERV;database=AIS20091217151735;user id=sa;password=whyb2009"
conn.Open connstr

Set cmd = New ADODB.Command

Set cmd.ActiveConnection = conn
cmd.CommandTimeout = 0
cmd.CommandText = "SHWorkBill_update1"
cmd.CommandType = adCmdStoredProc
conn.CursorLocation = adUseClient

Set rs = New ADODB.Recordset

    cmd.Parameters(1) = "A"    ' ---输入参数
    cmd.Parameters(2) = "C"    ' ---输入参数
    cmd.Parameters(3) = fgzl   ' ---输入参数
    cmd.Parameters(4) = fnumber     ' --- 输入参数
    cmd.Parameters(5) = ""          ' --- 输出参数
          
Set rs = cmd.Execute()
ReturnValue = cmd.Parameters(0)    '存储过程的返回值，返回0则成功执行

'MsgBox ReturnValue
ErrStr1 = cmd.Parameters(4)   '把存储过程的输出参数的值赋给变量strS8

If ErrStr1 <> "" Then
     MsgBox "警告信息: " + ErrStr1
Else

    If cmd.Parameters(0).Value = 1 Then
      
         MsgBox "更新失败,请重新核查!"
      
    Else
      
         MsgBox "更新完成!"
      
    End If
            
End If


Set rs = Nothing
Set conn = Nothing

End Sub

Private Sub C_inquiry2_Click()
Dim ReturnValue As Integer
Dim ErrStr1 As String

If IsNull(T_fgzl.Text) Or T_fgzl.Text = "" Then
fgzl = "%"
Else
fgzl = T_fgzl.Text
End If

If IsNull(Text_fnumber.Text) Or Text_fnumber.Text = "" Then
fnumber = "%"
Else
fnumber = Text_fnumber.Text + "%"
End If

If CMB_FQUFEN.ListIndex = -1 Then
        fqufen = "A"
    ElseIf CMB_FQUFEN.ListIndex = 0 Then
        fqufen = "A"
    ElseIf CMB_FQUFEN.ListIndex = 1 Then
        fqufen = "B"
    Else
        fqufen = "A"
    End If

Set conn = New ADODB.Connection
connstr = "provider=sqloledb.1;persist security info = true;server=DBSERV;database=AIS20091217151735;user id=sa;password=whyb2009"
conn.Open connstr

Set cmd = New ADODB.Command

Set cmd.ActiveConnection = conn
cmd.CommandTimeout = 0
cmd.CommandText = "SHWorkBill_update1"
cmd.CommandType = adCmdStoredProc
conn.CursorLocation = adUseClient

Set rs = New ADODB.Recordset

cmd.Parameters(1) = "B"   ' ---输入参数
cmd.Parameters(2) = fqufen  ' ---输入参数
cmd.Parameters(3) = fgzl   ' ---输入参数
cmd.Parameters(4) = fnumber     ' --- 输入参数
cmd.Parameters(5) = ""          ' --- 输出参数
          
Set rs = cmd.Execute()

Set DataGrid2.DataSource = rs
DataGrid2.Refresh

Set rs = Nothing
Set conn = Nothing
End Sub

Private Sub C_update2_Click()
Dim ReturnValue As Integer
Dim ErrStr1 As String

If IsNull(T_fgzl.Text) Or T_fgzl.Text = "" Then
fgzl = "%"
Else
fgzl = T_fgzl.Text
End If

If IsNull(Text_fnumber.Text) Or Text_fnumber.Text = "" Then
fnumber = "%"
Else
fnumber = Text_fnumber.Text + "%"
End If

If MsgBox("确认更新工序汇报数据吗？", vbYesNo) <> vbYes Then Exit Sub

Set conn = New ADODB.Connection
connstr = "provider=sqloledb.1;persist security info = true;server=DBSERV;database=AIS20091217151735;user id=sa;password=whyb2009"
conn.Open connstr

Set cmd = New ADODB.Command

Set cmd.ActiveConnection = conn
cmd.CommandTimeout = 0
cmd.CommandText = "SHWorkBill_update1"
cmd.CommandType = adCmdStoredProc
conn.CursorLocation = adUseClient

Set rs = New ADODB.Recordset

    cmd.Parameters(1) = "B"    ' ---输入参数
    cmd.Parameters(2) = "C"    ' ---输入参数
    cmd.Parameters(3) = fgzl   ' ---输入参数
    cmd.Parameters(4) = fnumber     ' --- 输入参数
    cmd.Parameters(5) = ""          ' --- 输出参数
          
Set rs = cmd.Execute()
ReturnValue = cmd.Parameters(0)    '存储过程的返回值，返回0则成功执行

'MsgBox ReturnValue
ErrStr1 = cmd.Parameters(4)   '把存储过程的输出参数的值赋给变量strS8

If ErrStr1 <> "" Then
     MsgBox "警告信息: " + ErrStr1
Else

    If cmd.Parameters(0).Value = 1 Then
      
         MsgBox "更新失败,请重新核查!"
      
    Else
      
         MsgBox "更新完成!"
      
    End If
            
End If


Set rs = Nothing
Set conn = Nothing
End Sub

Private Sub C_inquiry3_click()
Dim ReturnValue As Integer
Dim ErrStr1 As String

If IsNull(T_fgzl.Text) Or T_fgzl.Text = "" Then
fgzl = "%"
Else
fgzl = T_fgzl.Text
End If

If IsNull(Text_fnumber.Text) Or Text_fnumber.Text = "" Then
fnumber = "%"
Else
fnumber = Text_fnumber.Text + "%"
End If

If CMB_FQUFEN.ListIndex = -1 Then
        fqufen = "A"
    ElseIf CMB_FQUFEN.ListIndex = 0 Then
        fqufen = "A"
    ElseIf CMB_FQUFEN.ListIndex = 1 Then
        fqufen = "B"
    Else
        fqufen = "A"
    End If

Set conn = New ADODB.Connection
connstr = "provider=sqloledb.1;persist security info = true;server=DBSERV;database=AIS20091217151735;user id=sa;password=whyb2009"
conn.Open connstr

Set cmd = New ADODB.Command

Set cmd.ActiveConnection = conn
cmd.CommandTimeout = 0
cmd.CommandText = "SHWorkBill_update1"
cmd.CommandType = adCmdStoredProc
conn.CursorLocation = adUseClient

Set rs = New ADODB.Recordset

cmd.Parameters(1) = "C"   ' ---输入参数
cmd.Parameters(2) = fqufen  ' ---输入参数
cmd.Parameters(3) = fgzl   ' ---输入参数
cmd.Parameters(4) = fnumber     ' --- 输入参数
cmd.Parameters(5) = ""          ' --- 输出参数
          
Set rs = cmd.Execute()

Set DataGrid3.DataSource = rs
DataGrid3.Refresh

Set rs = Nothing
Set conn = Nothing

End Sub

Private Sub C_udpate3_Click()

Dim ReturnValue As Integer
Dim ErrStr1 As String

If IsNull(T_fgzl.Text) Or T_fgzl.Text = "" Then
fgzl = "%"
Else
fgzl = T_fgzl.Text
End If

If IsNull(Text_fnumber.Text) Or Text_fnumber.Text = "" Then
fnumber = "%"
Else
fnumber = Text_fnumber.Text + "%"
End If

If MsgBox("确认更新计件工资数据吗？", vbYesNo) <> vbYes Then Exit Sub

Set conn = New ADODB.Connection
connstr = "provider=sqloledb.1;persist security info = true;server=DBSERV;database=AIS20091217151735;user id=sa;password=whyb2009"
conn.Open connstr

Set cmd = New ADODB.Command

Set cmd.ActiveConnection = conn
cmd.CommandTimeout = 0
cmd.CommandText = "SHWorkBill_update1"
cmd.CommandType = adCmdStoredProc
conn.CursorLocation = adUseClient

Set rs = New ADODB.Recordset

    cmd.Parameters(1) = "C"          ' ---输入参数
    cmd.Parameters(2) = "C"         ' ---输入参数
    cmd.Parameters(3) = fgzl        ' ---输入参数
    cmd.Parameters(4) = fnumber     ' --- 输入参数
    cmd.Parameters(5) = ""          ' --- 输出参数
          
Set rs = cmd.Execute()
ReturnValue = cmd.Parameters(0)    '存储过程的返回值，返回0则成功执行

'MsgBox ReturnValue
ErrStr1 = cmd.Parameters(4)   '把存储过程的输出参数的值赋给变量strS8

If ErrStr1 <> "" Then
     MsgBox "警告信息: " + ErrStr1
Else

    If cmd.Parameters(0).Value = 1 Then
      
         MsgBox "更新失败,请重新核查!"
      
    Else
      
         MsgBox "更新完成!"
      
    End If
            
End If


Set rs = Nothing
Set conn = Nothing
End Sub

Private Sub Form_Load()
CMB_FQUFEN.Text = "差异查询"

End Sub


