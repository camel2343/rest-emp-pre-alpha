sleep(1)
para = 1000
prestij = 0
memnun = 0
calisan = 0
cargo= 0

menu = []
soslar = {}

puts "
██████╗ ███████╗███████╗████████╗     ███████╗███╗   ███╗██████╗ ██████╗
██╔══██╗██╔════╝██╔════╝╚══██╔══╝     ██╔════╝████╗ ████║██╔══██╗██╔══██╗
██████╔╝█████╗  █████╗     ██║        █████╗  ██╔████╔██║██████╔╝██████╔╝
██╔═══╝ ██╔══╝  ██╔══╝     ██║        ██╔══╝  ██║╚██╔╝██║██╔═══╝ ██╔═══╝
██║     ███████╗███████╗   ██║        ███████╗██║ ╚═╝ ██║██║     ██║
╚═╝     ╚══════╝╚══════╝   ╚═╝        ╚══════╝╚═╝     ╚═╝╚═╝     ╚═╝

          🍔  🍕  🍟  REST EMP  🍣  🍩  🍜
         ┌──────────────────────────────┐
         │  Şubelerini aç, para kazan!  │
         │  Çalışan işe al, prestij yükselt! │
         │  Kendi sosunu oluştur!       │
         └──────────────────────────────┘
"

puts "Şirketinizin adı nedir?"
ad = gets.chomp
puts "#{ad} çok iyi bir seçim!"

loop do
  puts "\nDurum: Para=#{para}, Şube=#{cargo}, Prestij=#{prestij}, Memnuniyet=#{memnun}, Çalışan=#{calisan}"
  puts "Menünüz: #{menu.empty? ? 'Henüz sos eklenmedi' : menu.join(', ')}"
  puts "Seçenekler:"
  puts "1- Şube aç (500 para, +1 şube, +4 çalışan)"
  puts "2- Reklam yap (200 para, +2 prestij)"
  puts "3- Müşteri hizmetlerini geliştir (300 para, +2 memnuniyet)"
  puts "4- Turu geç (şubeleriniz çalışır, gelir kazanırsınız)"
  puts "5- Çalışan işe al (100 para, +1-4 çalışan, +1-3 memnuniyet)"
  puts "6- Oyunu bitir"
  puts "7- Kendi sosunu oluştur (700 para 1-5 arası memnuniyet artışı"

  secim = gets.chomp.to_i

  case secim
  when 1
    if para >= 500
      para -= 500
      cargo += 1
      calisan += 4
      puts "Yeni bir şube açtınız!"
    else
      puts "Yeterli paranız yok!"
    end
  when 2
    if para >= 200
      para -= 200
      prestij += 2
      puts "Reklam kampanyası başarılı oldu!"
    else
      puts "Yeterli paranız yok!"
    end
  when 3
    if para >= 300
      para -= 300
      memnun += 2
      puts "Müşteri memnuniyeti arttı!"
    else
      puts "Yeterli paranız yok!"
    end
  when 4
    gelir = cargo * 150 + calisan * 10
    menu.each do |s|
      gelir += soslar[s][:memnun] * 20
      memnun += soslar[s][:memnun]
    end
    para += gelir
    puts "Şubeleriniz çalıştı, #{gelir} para kazandınız! Menüdeki soslar memnuniyeti artırdı."
  when 5
    if para >= 100
      para -= 100
      yeni_calisan = rand(1..4)
      yeni_memnun = rand(1..3)
      calisan += yeni_calisan
      memnun += yeni_memnun
      puts "#{yeni_calisan} yeni çalışan işe alındı, memnuniyet +#{yeni_memnun}!"
    else
      puts "Yeterli paranız yok!"
    end
  when 6
    puts "Oyun bitti. Şirketinizin son durumu:"
    puts "Para: #{para}, Şube sayısı: #{cargo}, Prestij: #{prestij}, Memnuniyet: #{memnun}, Çalışan: #{calisan}"
    puts "Menüdeki soslar: #{menu.join(', ')}"
    break
  when 7
    if para >= 700
      para -= 700
    end
    puts "Sosun adını girin:"
    ad_sos = gets.chomp
    puts "Sosun fiyatını girin:"
    fiyat = gets.chomp.to_i
    puts "Sosun memnuniyet etkisi oluşturuluyor..."
    memnun_etki = rand 1..5
    puts "sosunuzun beğenilme oranı:"+memnun_etki.to_s
    soslar[ad_sos] = { fiyat: fiyat, memnun: memnun_etki }
    puts "#{ad_sos} sosu oluşturuldu! Menüye eklemek ister misiniz? (e/h)"
    ekle = gets.chomp.downcase
    if ekle == "e"
      menu << ad_sos
      puts "#{ad_sos} menünüze eklendi!"
    else
      puts("paranız yok")
    end
  else
    puts "Geçersiz seçim!"
  end


  if rand(100) < 30
    olaylar = [
      ["Bir şubeniz kapandı!", -> { cargo -= 1 if cargo > 0; memnun -= 1 if memnun > 0 }],
      ["Devlet teşviki aldınız!", -> { para += 500 }],
      ["Rakip firma reklam yaptı, prestijiniz azaldı!", -> { prestij -= 1 if prestij > 0 }],
      ["Müşteriler hizmetinizden çok memnun!", -> { memnun += 2 }],
      ["Şubelerinizden biri ekstra iş buldu!", -> { para += 300 }],
      ["Hammadde fiyatları arttı, giderleriniz yükseldi!", -> { para -= 200 if para >= 200 }],
      ["Yemeğinizin içinden tuhaf bir şey çıktı ama insanlar size güvendi!", -> { prestij += 1 }]
    ]

    olay = olaylar.sample
    puts "\n--- OLAY ---"
    puts olay[0]
    puts "OLAY ÖNCESİ: Para=#{para}, Şube=#{cargo}, Prestij=#{prestij}, Memnun=#{memnun}, Çalışan=#{calisan}"
    olay[1].call
    puts "OLAY SONRASI: Para=#{para}, Şube=#{cargo}, Prestij=#{prestij}, Memnun=#{memnun}, Çalışan=#{calisan}"
  end
end
