#use_bpm 120

#Vars for funtions
bassPossibilities = [[1],[1.5],[0.5,1],[0.5,1.5],[0.5,0.5,1],[0.5,0.5,1.5]]
use_random_seed Time.now.to_i #Always different pattern

#Funtions
# Bass Pattern Generator
define :randomPattern do
    adder = (3..8).to_a.choose
    
    while true
      pattern = []
      
      adder.times do
        pattern += bassPossibilities.choose
      end
    
      total = (pattern.sum * 2).to_i
    
      if total % 8 == 0 && total <= 24
        return pattern
      end
    end
end
  
  
#Kick Pattern Generator
define :kickBeats do |hits, beats|
    grid = (0...(beats*2)).map{|i| i*0.5}
    hits = [hits, 1].max
    introGridKick = grid.shuffle.take(hits).sort
    
    sleeps = []
    last = 0
    
    introGridKick.each do |p|
      sleeps.push(p - last)
      last = p
    end
    
    sleeps.push(beats - last)
    
    return sleeps
end

#Play kick pattern
define :playKickPattern do |pattern, amp|
  pattern[0...-1].each do |s|
    sleep s
    sample :bd_sone, amp: amp
  end
  sleep pattern[-1]
end

#Play external samples
define :playExternalSample do |externalSample, pattern|
  pattern[0...-1].each do |s|
    sleep s
    sample externalSample, rate: [1.1, 1.15, 1.20].choose, amp: [0.5, 0.6, 0.7].choose
  end
  sleep pattern[-1]
end

# external sample effects, maybe It will get out
define :fx_externalSample do |&block|
  with_fx :lpf, cutoff: [100, 105, 110, 115, 120].choose, res: 0.7 do
    with_fx :echo, phase: 0.25, mix: 0.1 do
      block.call
    end
  end
end
  
#Vars for song
#Bass
set :notesBass, (ring :as2, :cs3, :f2, :cs3, :gs2)
#trumpet
set :notesTrumpet, (ring :cs4, :ds4, :f4)
#Fake voice
set :notesVoice, (ring :c4, :d4, :g3, :a3)
#Piano
set :notesPiano, (ring :as4, :cs5, :f4, :cs5, :gs4)
#Blade
set :notesBlade, (ring :as4, :cs5, :f4, :cs5, :gs4)

#INTRO
introSleepBass = randomPattern
introSleepTrumpet = randomPattern
introSleepKickB = kickBeats(introSleepBass.length - 2, (introSleepBass.sum).to_i)
introSleepKickT = kickBeats(introSleepTrumpet.length - 2, (introSleepTrumpet.sum).to_i)

#VERSE
verseSleepBass = randomPattern
verseSleepTrumpet = randomPattern
verseSleepFakeVoice = randomPattern
verseSleepKickB = kickBeats(verseSleepBass.length - 2, (verseSleepBass.sum).to_i)
verseSleepKickT = kickBeats(verseSleepTrumpet.length - 2, (verseSleepTrumpet.sum).to_i)
verseSleepKickFV = kickBeats(verseSleepFakeVoice.length - 2, (verseSleepFakeVoice.sum).to_i)

#DANCE BRAKE
danceBrakeSleepBass = randomPattern
danceBrakeSleepTrumpet = danceBrakeSleepBass
danceBrakeSleepFakeVoice = danceBrakeSleepBass
danceBrakeSleepKickB = kickBeats(danceBrakeSleepBass.length - 2, (danceBrakeSleepBass.sum).to_i)

#BRIDGE
bridgeSleepPiano = verseSleepBass
bridgeSleepBlade = bridgeSleepPiano
bridgeSleepKickP = kickBeats(bridgeSleepPiano.length - 2, (bridgeSleepPiano.sum).to_i)

#OUTRO1
outro1SleepBass = verseSleepBass
outro1SleepKickB = kickBeats(outro1SleepBass.length - 2, (outro1SleepBass.sum).to_i)

#OUTRO2
outro2SleepBass = outro1SleepBass
outro2SleepTrumpet = verseSleepTrumpet
outro2SleepFakeVoice = verseSleepFakeVoice
outro2SleepKickB = verseSleepKickB
outro2SleepKickT = verseSleepKickT
outro2SleepKickFV = verseSleepKickFV

#OUTRO3
outro3SleepBass = danceBrakeSleepBass
outro3SleepTrumpet = outro3SleepBass
outro3SleepFakeVoice = outro3SleepBass
outro3SleepKickB = danceBrakeSleepKickB

#Lyric Samples
#Check the adress
baseAddress = "D:/Arte/Composiciones/A-bird/aBird/samplesElectro/"
lyricSamples = [baseAddress + "get.wav", baseAddress + "come.wav", baseAddress + "feel.wav", baseAddress + "hey.wav", baseAddress + "right.wav", baseAddress + "uh.wav"]

#Fresh internal sample
freshInternalSamples = {clap_on: :perc_snap, robot_on: :glitch_robot2, tom_on: :drum_tom_mid_soft, choir_on: :ambi_choir}

#Instruments Hashes
#Bass
bassSleeps = {ib: :introSleepBass, vb: :verseSleepBass, db: :danceBrakeSleepBass, o1b: :outro1SleepBass, o2b: :outro2SleepBass, o3b: :outro3SleepBass}
trumpetSleeps = {it: :introSleepTrumpet, vt: :verseSleepTrumpet, dt: :danceBrakeSleepTrumpet, o2t: :outro2SleepTrumpet, o3t: :outro3SleepTrumpet}
kickSleeps = {ikb: :introSleepKickB, ikt: :introSleepKickT, vkb: :verseSleepKickB, vkt: :verseSleepKickT, vkv: :verseSleepKickFV, dkb: :danceBrakeSleepKickB, bkp: :bridgeSleepKickP, o1kb: :outro1SleepKickB, o2kb: :outro2SleepKickB, o2kt: :outro2SleepKickT, o2kv: :outro2SleepKickFV, o3kb: :outro3SleepKickB}
fakeVoiceSleeps = {vv: :verseSleepFakeVoice, dv: :danceBrakeSleepFakeVoice, o2v: :outro2SleepFakeVoice, o3v: :outro3SleepFakeVoice}
pianoSleeps = {bp: :bridgeSleepPiano}
bladeSleeps = {bb: :bridgeSleepBlade}

live_loop :metro do
  sleep 0.5
end

