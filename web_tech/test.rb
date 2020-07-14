require 'webrick'#webrickを呼び出す
server = WEBrick::HTTPServer.new({#インスタンスを作成してserver変数に代入
  :DocumentRoot => '.',#ドメインになる
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,#実行できるプログラムの本体の場所
  :Port => '3000',#情報の出入り口を表す設定
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')#./testというURLが送信される
server.mount('/kadai', WEBrick::HTTPServlet::ERBHandler, 'kadai.html.erb')#./testというURLが送信される
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')#htmlのformをindicate.rbに送ることができる
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.start#サーバの起動
