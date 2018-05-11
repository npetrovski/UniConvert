using System;
using System.IO;
using System.Text;
using System.Windows.Forms;
using System.Collections.Generic;
using System.Drawing;
using System.Reflection;
using Ude;

static class Program
{

    [STAThread]
    static void Main(string[] args)
    {
        Application.EnableVisualStyles();
        Application.SetCompatibleTextRenderingDefault(false);

        List<string> p = new List<string>(args);

        if (p.Count == 0)
        {


            OpenFileDialog dialog = new OpenFileDialog();

            dialog.Title = "Open file";
            dialog.InitialDirectory = @"c:\\";
            dialog.Filter = "txt files (*.txt)|*.txt|subtitle files (*.srt)|*.srt|All files (*.*)|*.*";
            dialog.FilterIndex = 2;
            dialog.RestoreDirectory = true;
            dialog.Multiselect = true;

            try
            {
                if (dialog.ShowDialog() == DialogResult.OK)
                {
                    Convert(dialog.FileNames, Encoding.Unicode);
                }
            }
            catch
            {

            }
        }
        else
        {
            bool cancel = false;
            Encoding enc = null;
            try
            {
                if ("unknown".Equals(p[0])) {
                    Form f = new Form();
                    f.Icon = Icon.ExtractAssociatedIcon(Assembly.GetExecutingAssembly().Location);
                    f.FormBorderStyle = FormBorderStyle.FixedSingle;
                    f.MaximizeBox = false;
                    f.MinimizeBox = false;
                    f.Width = 240;
                    f.Height = 115;
                    f.TopMost = true;
                    f.Load += (sender, e) =>
                    {
                        f.SetDesktopLocation(Cursor.Position.X - f.Width/2, Cursor.Position.Y - f.Height/2);
                    };
                    f.Text = "Select encoding";
                        f.FormClosed += (sender, e) => {
                        cancel = (f.DialogResult != DialogResult.OK);
                    };
                    ComboBox combo = new ComboBox() { Left = 10, Top = 10, Width = 200, DropDownStyle = ComboBoxStyle.DropDownList };
                    combo.Items.Clear();
                    combo.Items.AddRange(new object[] { "Unicode",
                                            "IBM037", "IBM437", "IBM500", "ASMO-708", "DOS-720", "IBM737",
                                            "IBM775", "IBM850", "IBM852", "IBM855", "IBM857", "IBM00858",
                                            "IBM860", "IBM861", "DOS-862", "IBM863", "IBM864", "IBM865",
                                            "cp866", "IBM869", "IBM870", "windows-874", "cp875",
                                            "Shift_jis", "gb2312", "ks_c_5601-1987", "big5", "IBM1026",
                                            "IBM01047", "IBM01140", "IBM01141", "IBM01142", "IBM01143",
                                            "IBM01144", "IBM01145", "IBM01146", "IBM01147", "IBM01148",
                                            "IBM01149", "UTF-16", "UTF-16BE", "Windows-1250",
                                            "Windows-1251", "Windows-1252", "Windows-1253", "Windows-1254",
                                            "Windows-1255", "Windows-1256", "Windows-1257", "Windows-1258",
                                            "Johab", "Macintosh", "x-mac-japanese", "x-mac-chinesetrad",
                                            "x-mac-korean", "x-mac-arabic", "x-mac-hebrew", "x-mac-greek",
                                            "x-mac-cyrillic", "x-mac-chinesesimp", "x-mac-romanian",
                                            "x-mac-ukrainian", "x-mac-thai", "x-mac-ce", "x-mac-icelandic",
                                            "x-mac-turkish", "x-mac-croatian", "UTF-32", "UTF-32BE",
                                            "x-Chinese-CNS", "x-cp20001", "x-Chinese-Eten", "x-cp20003",
                                            "x-cp20004", "x-cp20005", "x-IA5", "x-IA5-German",
                                            "x-IA5-Swedish", "x-IA5-Norwegian", "US-ASCII", "x-cp20261",
                                            "x-cp20269", "IBM273", "IBM277", "IBM278", "IBM280", "IBM284",
                                            "IBM285", "IBM290", "IBM297", "IBM420", "IBM423", "IBM424",
                                            "x-EBCDIC-KoreanExtended", "IBM-Thai", "koi8-r", "IBM871",
                                            "IBM880", "IBM905", "IBM00924", "EUC-JP", "x-cp20936",
                                            "x-cp20949", "cp1025", "koi8-u", "ISO-8859-1", "ISO-8859-2",
                                            "ISO-8859-3", "ISO-8859-4", "ISO-8859-5", "ISO-8859-6",
                                            "ISO-8859-7", "ISO-8859-8", "ISO-8859-9", "ISO-8859-13",
                                            "ISO-8859-15", "x-Europa", "ISO-8859-8-i", "ISO-2022-jp",
                                            "csISO2022JP", "ISO-2022-jp", "ISO-2022-kr", "x-cp50227",
                                            "euc-jp", "EUC-CN", "euc-kr", "hz-gb-2312", "GB18030",
                                            "x-iscii-de", "x-iscii-be", "x-iscii-ta", "x-iscii-te",
                                            "x-iscii-as", "x-iscii-or", "x-iscii-ka", "x-iscii-ma",
                                            "x-iscii-gu", "x-iscii-pa", "UTF-7", "UTF-8"
                                        });
                    combo.SelectedIndex = 0;

                    Button acceptBtn = new Button() { Text = "OK", Left = 50, Width = 80, Top = 45, DialogResult = DialogResult.OK };
                    Button cancelBtn = new Button() { Text = "Cancel", Left = 140, Width = 80, Top = 45, DialogResult = DialogResult.Cancel };
                    f.AcceptButton = acceptBtn;
                    f.CancelButton = cancelBtn;

                    acceptBtn.Click += (sender, e) =>
                    {
                        p[0] = (string) combo.SelectedItem;
                    };
                    f.Controls.Add(acceptBtn);
                    f.Controls.Add(cancelBtn);
                    //prompt.Controls.Add(textLabel);
                    f.Controls.Add(combo);
                    f.ShowDialog();
                }

                enc = Encoding.GetEncoding(p[0]);
            }
            catch
            {
                // no-op
            }

            if (false == cancel)
            {
                if (null != enc)
                {
                    p.RemoveAt(0);
                    Convert(p.ToArray(), enc);
                }
                else
                {
                    Convert(p.ToArray(), Encoding.Unicode);
                }
            }

            
        }

        
        //Application.Run(new Main());
        //Application.Run();
        Application.Exit();
    }

    public static void Convert(string[] args)
    {
        Convert(args, Encoding.Unicode);
    }

	public static void Convert(string[] args, Encoding enc)
	{

        if (args.Length > 0 ) {

            //string msg = "";

		    for (int i = 0; i < args.Length; i++)
    	    {
                string path = args[i];

                if (File.Exists(path)) {
                    
                    Encoding currentEncoding = findEncoding( path );

                    
                    if (!enc.Equals(currentEncoding)) {

                        byte[] b = Encoding.Convert(currentEncoding, enc, File.ReadAllBytes( path ));
                        
                        using (StreamWriter sw = new StreamWriter(path, false, enc))
                        {
                            sw.Write(enc.GetString(b));
                            sw.Close();

                            //msg += string.Format("File \"{0}\" converted.\n", path);
                        }
                    }
                }
    	    }

            //if (msg.Length > 0)
            //{
            //    MessageBox.Show(msg, "Done", MessageBoxButtons.OK);
            //}
               
		}

        //MessageBox.Show("No input file not specified", "Error", MessageBoxButtons.OK);

        //Application.Exit();
	}


    private static Encoding findEncoding(string path) {
        
        using (FileStream fs = File.OpenRead(path)) {
            CharsetDetector cdet = new CharsetDetector();
            cdet.Feed(fs);
            cdet.DataEnd();
            
            if (cdet.Charset != null) {
                return Encoding.GetEncoding(cdet.Charset);
            }
        }
            
        
        return Encoding.ASCII;
    }
}