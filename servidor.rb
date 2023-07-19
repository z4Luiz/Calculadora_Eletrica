require 'webrick'
require 'erb'

class CustomHandler < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    response.status = 200
    response.content_type = 'text/html'

    
    if request.path == '/u'
      erb_template = File.read('calculator-u.html.erb')
      response.body = render_template(erb_template)
      
    elsif request.path == '/i'
      erb_template = File.read('calculator-i.html.erb')
      response.body = render_template(erb_template)

    elsif request.path == '/r'
      erb_template = File.read('calculator-r.html.erb')
      response.body = render_template(erb_template)

    elsif request.path == '/p'
      erb_template = File.read('calculator-p.html.erb')
      response.body = render_template(erb_template)

    elsif request.path == '/ac'
      erb_template = File.read('calculator-ac.html.erb')
      response.body = render_template(erb_template)

    elsif request.path == '/convert'
      erb_template = File.read('calculator-convert.html.erb')
      response.body = render_template(erb_template)
    else
      response.status = 302
      response.header['Location'] = 'https://z4luiz.my.canva.site/'
    end
  end


  
  def do_POST(request, response)
    response.status = 200
    response.content_type = 'text/html; charset=UTF-8'

    if request.path == '/u'
      num1 = request.query['num1'].to_f
      num2 = request.query['num2'].to_f
      @result = num1 * num2
      erb_template = File.read('calculator-u.html.erb', encoding: 'utf-8')
      response.body = render_template(erb_template)
      
    elsif request.path == '/i'
      num1 = request.query['num1'].to_f
      num2 = request.query['num2'].to_f
      @result = num1.to_f / num2
      erb_template = File.read('calculator-i.html.erb', encoding: 'utf-8')
      response.body = render_template(erb_template)
      
    elsif request.path == '/r'
      num1 = request.query['num1'].to_f
      num2 = request.query['num2'].to_f
      @result = num1.to_f / num2
      erb_template = File.read('calculator-r.html.erb', encoding: 'utf-8')
      response.body = render_template(erb_template)

    elsif request.path == '/p'
      num1 = request.query['num1'].to_f
      num2 = request.query['num2'].to_f
      @result = num1 * num2
      erb_template = File.read('calculator-p.html.erb', encoding: 'utf-8')
      response.body = render_template(erb_template)

    elsif request.path == '/ac'
      diametro = request.query['diametro'].to_f
      r = diametro / 2
      pi = 3.14
      calculo = r * r
      @result = pi * calculo
      erb_template = File.read('calculator-ac.html.erb', encoding: 'utf-8')
      response.body = render_template(erb_template)

    elsif request.path == '/convert'
      valor = request.query['valor'].to_f
      operator = request.query['operator']
      case operator
      when "mili"
        calcular = valor * 1000
        @result = "#{calcular}mA"
      when "inteiro"
        calcular = valor / 1000
        @result = "#{calcular}A"
      end
      erb_template = File.read('calculator-convert.html.erb', encoding: 'utf-8')
      response.body = render_template(erb_template)
    end
  end

  private

  def render_template(template)
    renderer = ERB.new(template)
    renderer.result(binding)
  end
end

server = WEBrick::HTTPServer.new(Port: 8000)
server.mount('/', CustomHandler)

trap('INT') { server.shutdown }
server.start