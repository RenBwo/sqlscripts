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
   StartUpPosition =   3  '����ȱʡ
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
         Name            =   "����"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "����"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Caption         =   "�Ƽ����ʲ�ѯ��"
      ColumnCount     =   18
      BeginProperty Column00 
         DataField       =   "�Ƽ����ʵ��ݱ��"
         Caption         =   "�Ƽ����ʵ��ݱ��"
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
         DataField       =   "�������"
         Caption         =   "�������"
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
         DataField       =   "��Ʒ������"
         Caption         =   "���ϳ�����"
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
         DataField       =   "��Ʒ����"
         Caption         =   "��������"
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
         DataField       =   "����㱨�й���ϵ��"
         Caption         =   "����㱨�й���ϵ��"
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
         DataField       =   "����㱨�й�������"
         Caption         =   "����㱨�й�������"
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
         DataField       =   "�Ƽ������й���ϵ��"
         Caption         =   "�Ƽ������й���ϵ��"
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
         DataField       =   "�Ƽ������еĹ�������"
         Caption         =   "�Ƽ������еĹ�������"
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
         DataField       =   "����㱨���ݱ��"
         Caption         =   "����㱨���ݱ��"
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
         DataField       =   "�ӹ�����"
         Caption         =   "�ӹ�����"
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
         DataField       =   "��λ�Ƽ�����"
         Caption         =   "��λ�Ƽ�����"
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
         DataField       =   "�Ƽ����ʺϼ�"
         Caption         =   "�Ƽ����ʺϼ�"
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
         DataField       =   "ʵ�ʼƼ����ʺϼ�"
         Caption         =   "ʵ�ʼƼ����ʺϼ�"
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
         DataField       =   "�Ƽ������嵥���ܹ���"
         Caption         =   "�Ƽ������嵥���ܹ���"
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
         DataField       =   "ʵ���ܹ���"
         Caption         =   "ʵ���ܹ���"
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
         DataField       =   "��������"
         Caption         =   "��������"
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
         DataField       =   "����"
         Caption         =   "����"
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
         DataField       =   "����ƻ������"
         Caption         =   "����ƻ������"
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
         Name            =   "����"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "����"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Caption         =   "����㱨��ѯ��"
      ColumnCount     =   9
      BeginProperty Column00 
         DataField       =   "����㱨���"
         Caption         =   "����㱨���"
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
         DataField       =   "�������"
         Caption         =   "�������"
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
         DataField       =   "��Ʒ������"
         Caption         =   "���ϳ�����"
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
         DataField       =   "��Ʒ����"
         Caption         =   "��������"
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
         DataField       =   "����ƻ�������ϵ��"
         Caption         =   "����ƻ�������ϵ��"
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
         DataField       =   "����㱨����ϵ��"
         Caption         =   "����㱨����ϵ��"
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
         DataField       =   "����ƻ�����������"
         Caption         =   "����ƻ�����������"
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
         DataField       =   "����㱨��������"
         Caption         =   "����㱨��������"
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
         DataField       =   "��������"
         Caption         =   "��������"
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
         Name            =   "����"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "����"
         Size            =   9
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Caption         =   "����ƻ�����ѯ��"
      ColumnCount     =   14
      BeginProperty Column00 
         DataField       =   "�������"
         Caption         =   "�������"
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
         DataField       =   "��Ʒ������"
         Caption         =   "��Ʒ������"
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
         DataField       =   "��Ʒ����"
         Caption         =   "��Ʒ����"
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
         DataField       =   "����·�߹���ϵ��"
         Caption         =   "����·�߹���ϵ��"
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
         DataField       =   "����·�߹�������"
         Caption         =   "����·�߹�������"
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
         DataField       =   "����·�ߵ�λ�Ƽ�����"
         Caption         =   "����·�ߵ�λ�Ƽ�����"
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
         DataField       =   "����ƻ�������ϵ��"
         Caption         =   "����ƻ�������ϵ��"
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
         DataField       =   "����ƻ�����������"
         Caption         =   "����ƻ�����������"
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
         DataField       =   "����ƻ�����λ�Ƽ�����"
         Caption         =   "����ƻ�����λ�Ƽ�����"
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
         DataField       =   "����ƻ�����"
         Caption         =   "����ƻ�����"
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
         DataField       =   "����ƻ�����������"
         Caption         =   "����ƻ�����������"
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
         DataField       =   "����ƻ����й����"
         Caption         =   "����ƻ����й����"
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
         DataField       =   "����·�߱��"
         Caption         =   "����·�߱��"
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
         DataField       =   "����·�߹����"
         Caption         =   "����·�߹����"
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
      Caption         =   "��������"
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
         Caption         =   "�Ƽ����ʸ���"
         Height          =   400
         Left            =   10200
         TabIndex        =   11
         Top             =   720
         Width           =   1725
      End
      Begin VB.CommandButton C_inquiry3 
         Caption         =   "�Ƽ����ʲ�ѯ"
         Height          =   400
         Left            =   10200
         TabIndex        =   10
         Top             =   240
         Width           =   1725
      End
      Begin VB.CommandButton C_update2 
         Caption         =   "����㱨����"
         Height          =   400
         Left            =   7920
         TabIndex        =   9
         Top             =   720
         Width           =   1725
      End
      Begin VB.CommandButton C_inquiry2 
         Caption         =   "����㱨��ѯ"
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
         Caption         =   "����ƻ�������"
         Height          =   400
         Left            =   5880
         TabIndex        =   4
         Top             =   720
         Width           =   1725
      End
      Begin VB.CommandButton C_inquiry1 
         Caption         =   "����ƻ�����ѯ"
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
         Caption         =   "���ϴ���"
         Height          =   375
         Left            =   3000
         TabIndex        =   14
         Top             =   240
         Width           =   975
      End
      Begin VB.Label Label3 
         Caption         =   "����:"
         Height          =   255
         Left            =   480
         TabIndex        =   7
         Top             =   760
         Width           =   735
      End
      Begin VB.Label Label2 
         Caption         =   "�������:"
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

cmd.Parameters(1) = "A"         ' ---�������
cmd.Parameters(2) = fqufen      ' ---�������
cmd.Parameters(3) = fgzl        ' ---�������
cmd.Parameters(4) = fnumber     ' --- �������
cmd.Parameters(5) = ""          ' --- �������
          
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

If MsgBox("ȷ�ϸ��¹���ƻ���������", vbYesNo) <> vbYes Then Exit Sub

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

    cmd.Parameters(1) = "A"    ' ---�������
    cmd.Parameters(2) = "C"    ' ---�������
    cmd.Parameters(3) = fgzl   ' ---�������
    cmd.Parameters(4) = fnumber     ' --- �������
    cmd.Parameters(5) = ""          ' --- �������
          
Set rs = cmd.Execute()
ReturnValue = cmd.Parameters(0)    '�洢���̵ķ���ֵ������0��ɹ�ִ��

'MsgBox ReturnValue
ErrStr1 = cmd.Parameters(4)   '�Ѵ洢���̵����������ֵ��������strS8

If ErrStr1 <> "" Then
     MsgBox "������Ϣ: " + ErrStr1
Else

    If cmd.Parameters(0).Value = 1 Then
      
         MsgBox "����ʧ��,�����º˲�!"
      
    Else
      
         MsgBox "�������!"
      
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

cmd.Parameters(1) = "B"   ' ---�������
cmd.Parameters(2) = fqufen  ' ---�������
cmd.Parameters(3) = fgzl   ' ---�������
cmd.Parameters(4) = fnumber     ' --- �������
cmd.Parameters(5) = ""          ' --- �������
          
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

If MsgBox("ȷ�ϸ��¹���㱨������", vbYesNo) <> vbYes Then Exit Sub

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

    cmd.Parameters(1) = "B"    ' ---�������
    cmd.Parameters(2) = "C"    ' ---�������
    cmd.Parameters(3) = fgzl   ' ---�������
    cmd.Parameters(4) = fnumber     ' --- �������
    cmd.Parameters(5) = ""          ' --- �������
          
Set rs = cmd.Execute()
ReturnValue = cmd.Parameters(0)    '�洢���̵ķ���ֵ������0��ɹ�ִ��

'MsgBox ReturnValue
ErrStr1 = cmd.Parameters(4)   '�Ѵ洢���̵����������ֵ��������strS8

If ErrStr1 <> "" Then
     MsgBox "������Ϣ: " + ErrStr1
Else

    If cmd.Parameters(0).Value = 1 Then
      
         MsgBox "����ʧ��,�����º˲�!"
      
    Else
      
         MsgBox "�������!"
      
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

cmd.Parameters(1) = "C"   ' ---�������
cmd.Parameters(2) = fqufen  ' ---�������
cmd.Parameters(3) = fgzl   ' ---�������
cmd.Parameters(4) = fnumber     ' --- �������
cmd.Parameters(5) = ""          ' --- �������
          
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

If MsgBox("ȷ�ϸ��¼Ƽ�����������", vbYesNo) <> vbYes Then Exit Sub

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

    cmd.Parameters(1) = "C"          ' ---�������
    cmd.Parameters(2) = "C"         ' ---�������
    cmd.Parameters(3) = fgzl        ' ---�������
    cmd.Parameters(4) = fnumber     ' --- �������
    cmd.Parameters(5) = ""          ' --- �������
          
Set rs = cmd.Execute()
ReturnValue = cmd.Parameters(0)    '�洢���̵ķ���ֵ������0��ɹ�ִ��

'MsgBox ReturnValue
ErrStr1 = cmd.Parameters(4)   '�Ѵ洢���̵����������ֵ��������strS8

If ErrStr1 <> "" Then
     MsgBox "������Ϣ: " + ErrStr1
Else

    If cmd.Parameters(0).Value = 1 Then
      
         MsgBox "����ʧ��,�����º˲�!"
      
    Else
      
         MsgBox "�������!"
      
    End If
            
End If


Set rs = Nothing
Set conn = Nothing
End Sub

Private Sub Form_Load()
CMB_FQUFEN.Text = "�����ѯ"

End Sub


