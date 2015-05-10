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

  task populate_game_datails_ps4: :environment do
    agent = Mechanize.new
    Game.where(:platform => "PS4").each do |game|
      page = agent.get("http://www.3djuegos.com" + game.link)
      if page.search("a.c2o.pad_3").length == 0
        if page.search("dl")[0].search("dd").length == 5
          game.game_type = page.search("dl")[0].search("dd")[1].try(:text)
          game_link_1 = page.search("dl")[0].search("dd")[1].search("a")[0].try(:attributes)
          game_link_2 = game_link_1["href"].try(:value) unless game_link_1.nil?
          game_dlc = Game.find_by_link(game_link_2) unless game_link_2.nil?
          game.game_dlc = game_dlc.try(:link)
          game.game_dlc_id = game_dlc.try(:id)
          game.developer = page.search("dl")[0].search("dd")[3].try(:text)
          game.publisher = page.search("dl")[0].search("dd")[4].try(:text)
        elsif page.search("dl")[0].search("dd").length == 4
          game.developer = page.search("dl")[0].search("dd")[2].try(:text)
          game.publisher = page.search("dl")[0].search("dd")[3].try(:text)
        end
      elsif page.search("a.c2o.pad_3").length > 0
        if page.search("dl")[0].search("dd").length == 6
          game.game_type = page.search("dl")[0].search("dd")[2].try(:text)
          game_link_1 = page.search("dl")[0].search("dd")[2].search("a")[0].try(:attributes)
          game_link_2 = game_link_1["href"].try(:value) unless game_link_1.nil?
          game_dlc = Game.find_by_link(game_link_2) unless game_link_2.nil?
          game.game_dlc = game_dlc.try(:link)
          game.game_dlc_id = game_dlc.try(:id)
          game.developer = page.search("dl")[0].search("dd")[4].try(:text)
          game.publisher = page.search("dl")[0].search("dd")[5].try(:text)
        elsif page.search("dl")[0].search("dd").length == 5
          game.developer = page.search("dl")[0].search("dd")[3].try(:text)
          game.publisher = page.search("dl")[0].search("dd")[4].try(:text)
        end
      end
      game.players = page.search("dl")[1].search("dd")[1].try(:text)
      game.duration = page.search("dl")[1].search("dd")[2].try(:text)
      game.language = page.search("dl")[1].search("dd")[3].try(:text)
      game.review_link = page.search(".pl2 li")[1].children[0].attributes["href"].try(:value)
      if game.review_link == "javascript:void(0);"
        game.review_link = nil
      end
      game.save
      puts "*" * 150
      puts game.inspect
      puts "*" * 150
    end
  end

  task populate_game_datails_ps3: :environment do
    agent = Mechanize.new
    Game.where(:platform => "PS3").each do |game|
      page = agent.get("http://www.3djuegos.com" + game.link)
      if page.search("a.c2o.pad_3").length == 0
        if page.search("dl")[0].search("dd").length == 5
          game.game_type = page.search("dl")[0].search("dd")[1].try(:text)
          game_link_1 = page.search("dl")[0].search("dd")[1].search("a")[0].try(:attributes)
          game_link_2 = game_link_1["href"].try(:value) unless game_link_1.nil?
          game_dlc = Game.find_by_link(game_link_2) unless game_link_2.nil?
          game.game_dlc = game_dlc.try(:link)
          game.game_dlc_id = game_dlc.try(:id)
          game.developer = page.search("dl")[0].search("dd")[3].try(:text)
          game.publisher = page.search("dl")[0].search("dd")[4].try(:text)
        elsif page.search("dl")[0].search("dd").length == 4
          game.developer = page.search("dl")[0].search("dd")[2].try(:text)
          game.publisher = page.search("dl")[0].search("dd")[3].try(:text)
        end
      elsif page.search("a.c2o.pad_3").length > 0
        if page.search("dl")[0].search("dd").length == 6
          game.game_type = page.search("dl")[0].search("dd")[2].try(:text)
          game_link_1 = page.search("dl")[0].search("dd")[2].search("a")[0].try(:attributes)
          game_link_2 = game_link_1["href"].try(:value) unless game_link_1.nil?
          game_dlc = Game.find_by_link(game_link_2) unless game_link_2.nil?
          game.game_dlc = game_dlc.try(:link)
          game.game_dlc_id = game_dlc.try(:id)
          game.developer = page.search("dl")[0].search("dd")[4].try(:text)
          game.publisher = page.search("dl")[0].search("dd")[5].try(:text)
        elsif page.search("dl")[0].search("dd").length == 5
          game.developer = page.search("dl")[0].search("dd")[3].try(:text)
          game.publisher = page.search("dl")[0].search("dd")[4].try(:text)
        end
      end
      game.players = page.search("dl")[1].search("dd")[1].try(:text)
      game.duration = page.search("dl")[1].search("dd")[2].try(:text)
      game.language = page.search("dl")[1].search("dd")[3].try(:text)
      game.review_link = page.search(".pl2 li")[1].children[0].attributes["href"].try(:value)
      if game.review_link == "javascript:void(0);"
        game.review_link = nil
      end
      game.save
      puts "*" * 150
      puts game.inspect
      puts "*" * 150
    end
  end
end
