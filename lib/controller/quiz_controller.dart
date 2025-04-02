import 'package:cricket_trivia/data/model/quiz_question_model.dart';
import 'package:cricket_trivia/view/player/match_detail_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/quiz/result_screen.dart';

class QuizController extends GetxController {
  final SharedPreferences sharedPreferences;
  QuizController({required this.sharedPreferences});

  RxInt currentQuestionIndex = 0.obs;
  RxInt score = 0.obs;
  RxList<bool> questionAnswered = <bool>[].obs;

  // List of quiz questions
  final List<QuizQuestion> questions = [
    QuizQuestion(
      question: "What colour are cricket balls?",
      options: ["Red", "Neon Green", "Yellow", "Blue"],
      correctAnswerIndex: 0,
      imagePath: "assets/images/quiz1.png",
    ),
    QuizQuestion(
      question: "How many stumps are there in total?",
      options: ["6", "4", "2", "3"],
      correctAnswerIndex: 0,
      imagePath: "assets/images/quiz2.png",
    ),
    QuizQuestion(
      question: "Which of these is a famous cricket tournament?",
      options: ["The Ashes", "The Smoke", "The Ice", "The Fire"],
      correctAnswerIndex: 0,
      imagePath: "assets/images/quiz3.png",
    ),
    QuizQuestion(
      question: "How many players in a cricket team?",
      options: ["11", "4", "12", "9"],
      correctAnswerIndex: 0,
      imagePath: "assets/images/quiz4.png",
    ),
    QuizQuestion(
      question: "What are cricket balls traditionally made of?",
      options: ["Leather", "Ham", "Felt", "Wood"],
      correctAnswerIndex: 0,
      imagePath: "assets/images/quiz5.png",
    ),
    QuizQuestion(
      question: "What are cricket bats traditionally made of?",
      options: ["Wood", "Metal", "Stone", "Jam"],
      correctAnswerIndex: 0,
      imagePath: "assets/images/quiz6.png",
    ),
    QuizQuestion(
      question: "Which of these countries is cricket NOT the national sport?",
      options: ["Brazil", "England", "Argentine", "India"],
      correctAnswerIndex: 0,
      imagePath: "assets/images/quiz7.png",
    ),
    QuizQuestion(
      question: "Till which year did 1 over had 4 balls bowled?",
      options: ["1889", "1923", "1924", "1888"],
      correctAnswerIndex: 0,
      imagePath: "assets/images/quiz8.png",
    ),
  ];

  @override
  void onInit() {
  super.onInit();
  questionAnswered.value = List.generate(questions.length, (index) => false);
  }

  void answerQuestion(int selectedIndex) {
    if (!questionAnswered[currentQuestionIndex.value]) {
      if (selectedIndex == questions[currentQuestionIndex.value].correctAnswerIndex) {
        score.value++;
      }
      questionAnswered[currentQuestionIndex.value] = true;

      // Wait for animation/feedback before moving to next question
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (currentQuestionIndex.value < questions.length - 1) {
          currentQuestionIndex.value++;
        } else {
          Get.to(() => ResultScreen());
        }
      });
    }
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    score.value = 0;
    questionAnswered.value = List.generate(questions.length, (index) => false);
  }

  final PageController pageController = PageController();
  var currentPage = 0.obs;

  // List of match details
  final List<Map<String, String>> matches = [
    {
      "image": "assets/images/kapil.png",
      "title": "Kapil Dev",
      //"viewers": "300 Million Viewers",
      "story": "Kapil Dev Ram Lal Nikhanj (pronunciation ; born 6 January 1959) is a former Indian cricketer. He was a middle order batsman and a fast bowler. Regarded as one of the greatest all-rounders to play the game, he is also Regarded as one of the greatest captains India ever had. He was named by Wisden as the Indian Cricketer of the Century in 2002.Dev captained the Indian cricket team that won the 1983 Cricket World Cup. He was India's national cricket coach between October 1999 and August 2000. He retired in 1994, holding the world record for the greatest number of wickets taken in Test cricket, a record subsequently broken by Courtney Walsh in 2000. At the time, he was also India's highest wicket taker in both major forms of cricket, Tests and ODIs. He is the first player to take 200 ODI wickets. He is the only player in the history of cricket to have taken more than 400 wickets (434 wickets) and scored more than 5000 runs in Tests, making him one of the greatest all-rounders to have played the game. On 11 March 2010, Dev was inducted into the ICC Cricket Hall of Fame."
    },
    {
      "image": "assets/images/hansie.png",
      "title": "Hansie Cronje",
      //"viewers": "400 Million Viewers",
      "story": 'Wessel Johannes "Hansie" Cronje (25 September 1969 – 1 June 2002) was a South African international cricketer and captain of the South African national cricket team in the 1990s. He was voted the 11th greatest South African in 2004 despite having been banned from cricket for life due to his role in a match-fixing scandal. He died in a plane crash in 2002. Cronje led South Africa to a record 23 wins in his 53 test matches, with just 11 losses. Under his captaincy they had won 99 ODIs. He along with coach Bob Woolmer were a deadly pair, which brought many wins to the nation.',
    },
    {
      "image": "assets/images/donald.png",
      "title": "Donald Bradman",
      //"viewers": "200 Million Viewers",
        "story": "Sir Donald George Bradman, AC (27 August 1908 – 25 February 2001), often referred to as \"The Don\", was an Australian international cricketer, widely acknowledged as the greatest batsman of all time. Bradman's career Test batting average of 99.94 has been cited as the greatest achievement by any sportsman in any major sport. The story that the young Bradman practised alone with a cricket stump and a golf ball is part of Australian folklore. Bradman's meteoric rise from bush cricket to the Australian Test team took just over two years. Before his 22nd birthday, he had set many records for top scoring, some of which still stand, and became Australia's sporting idol at the height of the Great Depression. During a 20-year playing career, Bradman consistently scored at a level that made him, in the words of former Australia captain Bill Woodfull, \"worth three batsmen to Australia\". A controversial set of tactics, known as Bodyline, was specifically devised by the England team to curb his scoring. As a captain and administrator, Bradman was committed to attacking, entertaining cricket; he drew spectators in record numbers. He hated the constant adulation, however, and it affected how he dealt with others. The focus of attention on his individual performances strained relationships with some teammates, administrators and journalists, who thought him aloof and wary. Following an enforced hiatus due to the Second World War, he made a dramatic comeback, captaining an Australian team known as \"The Invincibles\" on a record-breaking unbeaten tour of England. A complex, highly driven man, not given to close personal relationships, Bradman retained a pre-eminent position in the game by acting as an administrator, selector and writer for three decades following his retirement. Even after he became reclusive in his declining years, his opinion was highly sought, and his status as a national icon was still recognised. Almost 50 years after his retirement as a Test player, in 1997, Prime Minister John Howard of Australia called him the \"greatest living Australian\". Bradman's image has appeared on postage stamps and coins, and a museum dedicated to his life was opened while he was still living. On the centenary of his birth, 27 August 2008, the Royal Australian Mint issued a 5 commemorative gold coin with Bradman's image. In 2009, he was inducted posthumously into the ICC Cricket Hall of Fame.",

    },
    {
      "image": "assets/images/khan.png",
      "title": "Imran Khan",
      //"viewers": "250 Million Viewers",
      "story": "Imran Ahmed Khan Niazi (Urdu: عمران احمد خان نیازی‎; born 5 October 1952) is the 22nd and current Prime Minister of Pakistan and the chairman of the Pakistan Tehreek-e-Insaf (PTI). Before entering politics, Khan was an international cricketer and captain of the Pakistan national cricket team, when he led the team to victory in the 1992 Cricket World Cup.Khan was born to an upper-middle class Pashtun family in Lahore in 1952; he was educated at Aitchison College in Lahore, then the Royal Grammar School Worcester in Worcester, and later at Keble College, Oxford. He started playing cricket at age 13, and made his debut for the Pakistan national cricket team at age 18, during a 1971 Test series against England. After graduating from Oxford, he made his home debut for Pakistan in 1976, and played until 1992. He also served as the team's captain intermittently between 1982 and 1992, notably leading Pakistan to victory at the 1992 Cricket World Cup, Pakistan's first and only victory in the competition.Khan retired from cricket in 1992, as one of Pakistan's most successful players. In total he made 3,807 runs and took 362 wickets in Test cricket, and is one of eight world cricketers to have achieved an 'All-rounder's Triple' in Test matches. After retiring, he faced scandal after admitting to tampering with the ball with a bottle top in his youth. In 2003, he became a coach in Pakistan's domestic cricket circuit, and in 2010, he was inducted into the ICC Cricket Hall of Fame. In 1991, he launched a fundraising campaign to set up a cancer hospital in memory of his mother. He raised 25 million to set up a hospital in Lahore in 1994, and set up a second hospital in Peshawar in 2015. Khan remains a prominent philanthropist and commentator, having expanded the Shaukat Khanum Memorial Cancer Hospital to also include a research centre, and founded Namal College in 2008. Khan also served as the chancellor of the University of Bradford between 2005 and 2014, and was the recipient of an honorary fellowship by the Royal College of Physicians in 2012.In April 1996, Khan founded the Pakistan Tehreek-e-Insaf (lit: Pakistan Movement for Justice), a centrist political party, and became the party's national leader. Khan contested for a seat in the National Assembly in October 2002 and served as an opposition member from Mianwali until 2007. He was again elected to the parliament in the 2013 elections, when his party emerged as the second largest in the country by popular vote. Khan served as the parliamentary leader of the party and led the third-largest block of parliamentarians in the National Assembly from 2013 to 2018. His party also led a coalition government in the north-western province of Khyber Pakhtunkhwa. In the 2018 general elections, his party won the largest number of seats and defeated the ruling PML-N, bringing Khan to premiership and the PTI into federal government for the first time.Khan remains a popular public figure and is the author of, among other publications, Pakistan: A Personal History.",
    },
    {
      "image": "assets/images/rahul.png",
      "title": "Rahul Dravid",
      //"viewers": "350 Million Viewers",
      "story": "Rahul Sharad Dravid ( (listen); born 11 January 1973) is a former Indian cricketer and captain of the Indian national team. He is the current Overseas Batting Consultant for the Indian team, and also the Head Coach for the India Under-19 and India A teams. Known for his sound batting technique, Dravid has scored nearly 25,000 runs in international cricket and is widely regarded as one of the greatest batsmen in the history of cricket. He is colloquially known as Dependable or Mr. Dependable, and often referred to as The Great Wall or The Wall by Indian cricket followers.Born in a Marathi family and brought up in Bangalore, he started playing cricket at the age of 12 and later represented Karnataka at the under-15, under-17 and under-19 levels. Hailed as The Wall, Dravid was named one of the best five cricketers of the year by Wisden Cricketers' Almanack in 2000 and received the Player of the Year and the Test Player of the Year awards at the inaugural ICC awards ceremony in 2004. In December 2011, he became the first non-Australian cricketer to deliver the Bradman Oration in Canberra.As of December 2016, Dravid is the fourth-highest run scorer in Test cricket, after Sachin Tendulkar, Ricky Ponting and Jacques Kallis. In 2004, after completing his century against Bangladesh in Chittagong, he became the first and the only player till date to score a century in all the ten Test-playing countries. As of October 2012, he holds the record for the most catches taken by a player (non-wicket-keeper) in Test cricket, with 210. Dravid holds a unique record of never getting out for a Golden duck in the 286 Test innings which he has played. He has faced 31258 balls, which is the highest number of balls faced by any player in test cricket. He has also spent 44152 minutes at the crease, which is the highest time spent on crease by any player in test cricket.In August 2011, after receiving a surprise recall in the ODI series against England, Dravid declared his retirement from ODIs as well as Twenty20 International (T20I), and in March 2012, he announced his retirement from international and first-class cricket. He appeared in the 2012 Indian Premier League as captain of the Rajasthan Royals.Rahul Dravid, along with Glenn McGrath were honoured during the seventh annual Bradman Awards function in Sydney on 1 November 2012. Dravid has also been honoured with the Padma Shri and the Padma Bhushan award, India's fourth and third highest civilian awards respectively.In 2014, Rahul Dravid joined the GoSports Foundation, Bangalore as a member of their board of advisors. In collaboration with GoSports Foundation he is mentoring India's future Olympians and Paralympians as part of the Rahul Dravid Athlete Mentorship Programme. Indian badminton player Prannoy Kumar, Para-swimmer Sharath Gayakwad and young Golfer S. Chikkarangappa was part of the initial group of athletes to be mentored by Rahul Dravid. In July 2018, Dravid became the fifth Indian cricketer to be inducted into ICC Hall of Fame.",
    },
    {
      "image": "assets/images/abdul.png",
      "title": "Abdul Qadir",
      //"viewers": "350 Million Viewers",
      "story": "Abdul Qadir Khan (Urdu: عبد القادر خان‎, born 15 September 1955 in Lahore) is a former Pakistani international cricketer whose main role was as a leg spin bowler. Later he was a commentator and Chief Selector of the Pakistan Cricket Board, from which post he resigned because of differences with the top brass of Pakistan cricket. Qadir appeared in 67 Test and 104 One Day International (ODI) matches between 1977 and 1993, and captained the Pakistan cricket team in five ODIs. In Test cricket, his best performance for a series was 30 wickets for 437 runs, in three test matches at home, against England in 1987. His best bowling figures for an innings were nine wickets for 56 against the same team at the Gaddafi Stadium in the same series in 1987. In ODIs, his best bowling figures were five wickets for 44 runs against Sri Lanka during the 1983 Cricket World Cup. He was a member of the Pakistani team in the 1983 and 1987 Cricket World Cups. Yahoo! Cricket described Qadir as \"a master of the leg-spin\" who \"mastered the googlies, the flippers, the leg-breaks and the topspins.\" He is widely regarded as a top spin bowler of his generation and was included in Richie Benaud's Greatest XI shortlist of an imaginary cricket team from the best players available from all countries and eras. Former English captain Graham Gooch said that \"Qadir was even finer than Shane Warne\"."
    },
    {
      "image": "assets/images/dhoni.png",
      "title": "Mahendra Singh Dhoni",
      //"viewers": "350 Million Viewers",
      "story": "Mahendra Singh Dhoni (pronunciation born 7 July 1981), commonly known as MS Dhoni, is an Indian international cricketer who captained the Indian national team in limited-overs formats from 2007 to 2016 and in Test cricket from 2008 to 2014. Under his captaincy, India won the 2007 ICC World Twenty20, the 2010 and 2016 Asia Cups, the 2011 ICC Cricket World Cup, and the 2013 ICC Champions Trophy. A right-handed middle-order batsman and wicket-keeper, Dhoni is one of the highest run scorers in One Day Internationals (ODIs) with more than 10,000 runs scored and is considered an effective \"finisher\" in limited-overs formats. He is also regarded by some as one of the best wicket-keepers in modern limited-overs international cricket. He made his ODI debut in December 2004 against Bangladesh and played his first Test a year later against Sri Lanka. Dhoni has been the recipient of many awards, including the ICC ODI Player of the Year award in 2008 and 2009 (the first player to win the award twice), the Rajiv Gandhi Khel Ratna award in 2007, the Padma Shri, India's fourth-highest civilian honour, in 2009, and the Padma Bhushan, India's third-highest civilian honour, in 2018. He was named as the captain of the ICC World Test XI in 2009, 2010, and 2013. He has also been selected a record eight times in ICC World ODI XI teams, five times as captain. The Indian Territorial Army conferred the honorary rank of Lieutenant Colonel to Dhoni on 1 November 2011. He is the second Indian cricketer after Kapil Dev to receive this honour. Dhoni also holds numerous captaincy records such as the most wins by an Indian captain in Tests, ODIs, and T20Is, and the most back-to-back wins by an Indian captain in ODIs. He took over the ODI captaincy from Rahul Dravid in 2007 and led the team to its first-ever bilateral ODI series wins in Sri Lanka and New Zealand. In June 2013, when India defeated England in the final of the Champions Trophy in England, Dhoni became the first captain to win all three ICC limited-overs trophies (World Cup, Champions Trophy, and World Twenty20). After taking up the Test captaincy in 2008, he led the team to series wins in New Zealand and the West Indies, and the Border-Gavaskar Trophy in 2008, 2010, and 2013. In 2009, Dhoni also led the Indian team to the number one position for the first time in the ICC Test rankings. In 2013, under his captaincy, India became the first team in more than 40 years to whitewash Australia in a Test series. In the Indian Premier League, he captained the Chennai Super Kings to victory in the 2010, 2011, and 2018 seasons, along with wins in the 2010 and 2014 editions of the Champions League Twenty20. In 2011, Time magazine included Dhoni in its annual Time 100 list as one of the \"Most Influential People in the World.\" Dhoni holds the post of Vice-President of India Cements Ltd., after resigning from Air India. India Cements is the owner of the IPL team Chennai Super Kings, and Dhoni has been its captain since the first IPL season. He announced his retirement from Tests on 30 December 2014. In 2012, SportsPro rated Dhoni as the sixteenth most marketable athlete in the world. Dhoni is the co-owner of the Indian Super League team Chennaiyin FC. In June 2015, Forbes ranked Dhoni at 23rd in the list of highest-paid athletes in the world, estimating his earnings at US 31 million. In 2016, a biopic, M.S. Dhoni: The Untold Story, was made about him."
    },
    {
      "image": "assets/images/perry.png",
      "title": "Ellyse Perry",
      //"viewers": "350 Million Viewers",
      "story": "Ellyse Alexandra Perry (born 3 November 1990) is an Australian sportswoman who made her debut for both the Australian cricket and the Australia women's national soccer team at the age of 16. She played her first cricket international in July 2007 before earning her first football cap for Australia a month later. Perry is the youngest person to represent Australia in cricket and the first Australian to have appeared in both cricket and football World Cups. Perry was fast-tracked to make her Women's One Day International (WODI) debut for Australia against New Zealand, three months before playing a single match for her state New South Wales in the Women's National Cricket League (WNCL). In 2007–08, she made her debut for New South Wales and won the WNCL with them, and at the end of the season, she made her Women's Test cricket debut in Bowral against England. During the season, she was the player of the match in her Women's Twenty20 International (WT20I) debut against England, and made her maiden WODI half-century against New Zealand. Perry took 4 wickets for 23 runs in the final of the 2008–09 WNCL to help New South Wales defend their title. She then took nine wickets as Australia came fourth in the 2009 World Cup held in Australia. She was ineffective during the 2009 ICC Women's World Twenty20 in England, taking only two wickets in Australia's four matches. In 2009–10, Perry took 22 wickets and scored 148 runs as New South Wales won the WNCL again. She then took 18 wickets in 10 WODIs against New Zealand at the end of the season, as the Australians won all the matches. During these matches, Perry took her maiden five-wicket WODI haul. Perry played in each of Australia's matches at the 2010 World Twenty20 in the West Indies, taking 3 wickets for 18 runs and being named player of the match in the final as Australia defeated New Zealand by three runs to claim the title. In December 2017, she won the inaugural ICC Women's Cricketer of the Year award. In November 2018, during the 2018 ICC Women's World Twenty20 tournament in the West Indies, Perry became the first cricketer for Australia, male or female, to play in 100 Twenty20 International matches. In the final of the same tournament, she became the first cricketer for Australia, male or female, to take 100 wickets in Twenty20 International matches. In July 2019, during the Women's Ashes, Perry became the first player, male or female, to score 1,000 runs and take 100 wickets in Twenty20 International cricket. A defender, Perry represented Australia at the 2008 Asian Cup, and scored in the match against South Korea. She played for the Central Coast Mariners in the Australian W-League during the 2008–09 season, before transferring to Canberra United the following year. In June 2010, Perry began her media career by hosting the football-related show Football Stars of Tomorrow, screened on the digital sports channel One HD. However, she hasn't played football for the national team since as the team did not call her up again."
    },

    {
      "image": "assets/images/bob.png",
      "title": "Bob Woolmer",
      //"viewers": "350 Million Viewers",
      "story": "Robert Andrew Woolmer (14 May 1948 – 18 March 2007), known as Bob Woolmer, was an English cricket coach, cricketer, and a commentator. He played in 19 Test matches and six One Day Internationals for the England cricket team and later coached South Africa, Warwickshire and Pakistan. On 18 March 2007, Woolmer died suddenly in Jamaica, just a few hours after the Pakistan team's unexpected elimination at the hands of Ireland in the 2007 Cricket World Cup. Shortly afterwards, Jamaican police announced that they were opening a murder investigation into Woolmer's death. In November 2007, a jury in Jamaica recorded an open verdict on Woolmer's death, concluding that Woolmer died of natural causes."
    },
    {
      "image": "assets/images/monty.png",
      "title": "Monty Panesar",
      //"viewers": "350 Million Viewers",
      "story": "Mudhsuden Singh Panesar (born 25 April 1982), known as Monty Panesar, is an English international cricketer who is currently without a county cricket side. A left-arm spinner, Panesar made his Test cricket debut in 2006 against India in Nagpur and One Day International debut for England in 2007. In English county cricket, he last played for Northamptonshire in 2016, and has previously played for Northamptonshire until 2009, Sussex from 2010–2013 and Essex from 2013-2015, He has also played for the Lions in South Africa. Born in Luton to Indian parents, Panesar is a Sikh, and so he wears a black patka (a smaller version of the full Sikh turban) while playing and training. Many of his fans have emulated him by wearing patkas and fake beards while watching him play. When first selected for England he was widely perceived as being a particularly inept batsman and fielder, which resulted in much ironic cheering; the TMS commentator Henry Blofeld once accidentally referred to him as Monty Python. Panesar lost his place in the England test team, being replaced by Graeme Swann and losing his central contract. However, his form improved with Sussex County Cricket Club, and so he was recalled to the squad for the 2010–11 Ashes series, although he did not feature in any matches. After taking 69 wickets in the 2011 county season Panesar earned a recall for the series against Pakistan In the UAE; he played in the second Test – his first Test appearance in over two and a half years. Panesar also played in 3 Test matches in India in 2012, before deputising for the injured Graeme Swann as lead spinner in the England tour of New Zealand, where he managed just 5 wickets costing 70 runs each. His last international series was against Australia in the 2013–14 Ashes though he has not announced retirement since. In January 2017, Panesar was recruited by Cricket Australia as a spin-bowling consultant for the tour of India, after spending his winter as a club cricketer in Sydney."
    },
    {
      "image": "assets/images/jonty.png",
      "title": "Jonty Rhodes",
      //"viewers": "350 Million Viewers",
      "story": "Jonathan Neil Rhodes (born 27 July 1969) is a South African cricket commentator and former Test and One Day International cricketer. He is commonly held as the greatest fielder of all time. He played for the South African cricket team between 1992 and 2003. Rhodes was born in Pietermaritzburg, Natal Province, South Africa. Whilst being noted for his quick running as a right-handed batsman, he was especially noted for his defensive fielding, particularly catching, ground fielding, and throwing from his most common position of backward point. A report prepared by Cricinfo in late 2005 showed that since the 1999 Cricket World Cup, he had effected the ninth-highest number of run outs in ODI cricket of any fieldsman, with the third-highest success rate. He is regarded as one of the greatest fielders of all time. During his career he also played club cricket for the University of Natal in Pietermaritzburg and first-class cricket for Gloucestershire County Cricket Club, KwaZulu-Natal, Natal and the Dolphins. Rhodes retired from Test cricket in 2000, and from one day cricket in 2003 after an injury during the 2003 Cricket World Cup. Rhodes also represented South Africa at hockey, and was chosen as part of the 1992 Olympic Games squad to go to Barcelona; however, the squad did not qualify to go to the tournament. He was also called up for trials to play in the 1996 Olympics but was ruled out by a hamstring injury."
    },{
      "image": "assets/images/ravi.png",
      "title": "Ravi Shastri",
      //"viewers": "350 Million Viewers",
      "story": "Ravishankar Jayadritha Shastri (born 27 May 1962) is an Indian cricket coach, former commentator, cricketer and current head coach of the Indian national cricket team. As a player, he played for the India national cricket team between 1981 and 1992 in both Tests and ODIs. Although he started his career as a left arm spin bowler, he later transformed into a batting all-rounder. As a batsman, Shastri was essentially defensive with his trademark \"chapati shot\" (a flick off the pads), but he could raise his strike rate when required. Due to his above-average height (he stood 6' 3\" tall) and an upright stance, he had a limited number of shots against fast bowling, but was able to put the lofted shot to good use against spin bowling. Ravi played either as an opening batsman or in the middle order. The highlight of his career was when he was elected Champion of Champions in the World Championship of Cricket in Australia in 1985. In the same season, on 10 January 1985, he equaled West Indian Garry Sobers's record of hitting six sixes in an over in first class cricket. He was regarded as a potential captain, but his image outside cricket, injuries and tendency to lose form at crucial times meant that he captained India in only one Test match. In domestic cricket, he played for Bombay and led them to the Ranji Trophy title in his final year of playing. He also played four seasons of county cricket for Glamorgan. He was forced to retire aged 31 due to a recurring knee injury. He has done commentary on behalf of BCCI in the matches that India play. In 2014, he became the director of Indian cricket team for a period of eight months from India's tour of England till the 2015 World Cup. On 13 July 2017, he was appointed as the head coach of Indian cricket team. On 16 August 2019, he was re-appointed as the head coach of the senior men's Indian team and will remain in charge until the 2021 ICC T20 World Cup."    },

   {
      "image": "assets/images/noori.png",
      "title": "Khaleqdaad Noori",
      //"viewers": "350 Million Viewers",
        "story": 'Khaleqdaad Noori (born 1 January 1984) is an Afghan cricketer. Khaleqdaad is a right-handed batsman who bowls right-arm fast-medium and plays for the Afghanistan national cricket team'
    },
  ];

  void nextPage() {
    if (currentPage.value < matches.length - 1) {
      pageController.animateToPage(
        currentPage.value + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.animateToPage(
        currentPage.value - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void openMatchStory() {
    Get.to(() => MatchDetailsScreen(
      title: matches[currentPage.value]["title"]!,
      story: matches[currentPage.value]["story"]!,
      image: matches[currentPage.value]["image"]!,
    ));
  }
}