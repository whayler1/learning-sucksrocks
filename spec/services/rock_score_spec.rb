require_relative "../../app/services/rock_score"
require_relative "../../app/services/search_engine"

describe RockScore do
  it "returns 0 for unpopular terms" do
    SearchEngine.stub(:count_results).with("apple rocks") { 0 }
    SearchEngine.stub(:count_results).with("apple sucks") { 1 }
    RockScore.for_term("apple").expect == 0.0
  end
  
  it "returns 10 for popular terms" do
    SearchEngine.stub(:count_results).with("apple rocks") { 1 }
    SearchEngine.stub(:count_results).with("apple sucks") { 0 }
    RockScore.for_term("apple").expect == 10.0
  end
  
  it "returns mediocre results for mediocre terms" do
    SearchEngine.stub(:count_results).with("apple rocks") { 9 }
    SearchEngine.stub(:count_results).with("apple sucks") { 11 }
    RockScore.for_term("apple").expect == 4.5
  end
  
  it "does not divide by 0" do
    SearchEngine.stub(:count_results).with("apple rocks") { 0 }
    SearchEngine.stub(:count_results).with("apple sucks") { 0 }
    RockScore.for_term("apple").expect == RockScore::NoScore
  end
end