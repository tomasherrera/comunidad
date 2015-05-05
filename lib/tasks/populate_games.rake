namespace :populate_games do
  require 'mechanize'
  desc "Populate games in db from 3dJuegos website"
  task populate: :environment do
    agent = Mechanize.new
    (0..26).each do |page_index|
      page = agent.get("http://www.3djuegos.com/novedades/juegos-generos/juegos-ps4/#{page_index}f37f0f0/juegos-populares/")
      page.search("td.s11.c2").each_with_index do |game, index|
        g = Game.new
        genres = []
        g.title = game.search("a.s16").first.content
        g.description = game.search("p").text
        g.juegos_score = game.search("div.val_cuadrado_gris.fr.mar_l16.mar_r2").try(:text)
        g.platform = game.search("span.c2c.n").text
        g.release_date = game.search("b").text
        g.link = game.search("a.s16").first.attributes["href"].value
        game.search("div.mar_t3.a_c1").search("a").each do |genre|
          genres << genre.text
        end
        g.genre = genres
        g.small_cover = page.search("img.mar_tb5.b_avatar_alfa")[index].attributes["src"].value

        # Getting url to get big cover
        game_page = agent.get('http://www.3djuegos.com' + g.link)
        begin
          cover_page = agent.get(game_page.search("div#caratula").search("a").first.attributes["href"].value)
          g.large_cover = cover_page.search("img.br2").first.attributes["src"].value
        rescue
          g.large_cover = "not_available"
        end

        if g.juegos_score.nil?
          g.juegos_score = "Sin Calificación"
        end

        g.save

        puts g.title
        puts "*" * 50
        puts "ps4"
      end
    end
  end

  task ps3_games: :environment do
    agent = Mechanize.new
    (0..97).each do |page_index|
      page = agent.get("http://www.3djuegos.com/novedades/juegos-generos/juegos-ps3/#{page_index}f2f0f0/juegos-populares/")
      page.search("td.s11.c2").each_with_index do |game, index|
        g = Game.new
        genres = []
        g.title = game.search("a.s16").first.content
        g.description = game.search("p").text
        g.juegos_score = game.search("div.val_cuadrado_gris.fr.mar_l16.mar_r2").try(:text)
        g.platform = game.search("span.c2c.n").text
        g.release_date = game.search("b").text
        g.link = game.search("a.s16").first.attributes["href"].value
        game.search("div.mar_t3.a_c1").search("a").each do |genre|
          genres << genre.text
        end
        g.genre = genres
        g.small_cover = page.search("img.mar_tb5.b_avatar_alfa")[index].attributes["src"].value

        # Getting url to get big cover
        game_page = agent.get('http://www.3djuegos.com' + g.link)
        begin
          cover_page = agent.get(game_page.search("div#caratula").search("a").first.attributes["href"].value)
          g.large_cover = cover_page.search("img.br2").first.attributes["src"].value
        rescue
          g.large_cover = "not_available"
        end

        if g.juegos_score.nil?
          g.juegos_score = "Sin Calificación"
        end

        g.save

        puts g.title
        puts "*" * 50
        puts "ps3"
      end
    end
  end

end
