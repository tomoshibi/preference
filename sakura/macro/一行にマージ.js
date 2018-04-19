//選択中のテキスト取得
var str = Editor.GetSelectedString(0);

//改行文字列置換
var oneLine = str.replace(/\r?\n/g,"");

Editor.InsText(oneLine);