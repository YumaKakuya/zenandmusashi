# frozen_string_literal: true

require_relative 'store'

module ZenAndMusashi
  module Seed
    DEFAULT_QUOTES = {
      'zen' => [
        # Authentic — verified Zen sources
        { text: 'Before enlightenment, chop wood, carry water. After enlightenment, chop wood, carry water.',
          type: 'authentic' },
        { text: 'The obstacle is the path.', type: 'authentic' },
        { text: 'The whole moon and the entire sky are reflected in one dewdrop on the grass.', type: 'authentic' },
        { text: 'Sitting quietly, doing nothing, spring comes and the grass grows by itself.', type: 'authentic' },
        { text: 'A flower falls, even though we love it; and a weed grows, even though we do not love it.',
          type: 'authentic' },
        { text: 'If you understand, things are just as they are. If you do not understand, things are just as they are.',
          type: 'authentic' },
        { text: 'No snowflake ever falls in the wrong place.', type: 'authentic' },
        { text: 'Not knowing is most intimate.', type: 'authentic' },
        { text: 'When walking, just walk. When sitting, just sit. Above all, do not wobble.', type: 'authentic' },
        {
          text: 'The ten thousand questions are one question. If you cut through the one question, then the ten thousand are answered.', type: 'authentic'
        },
        {
          text: 'In the landscape of spring there is neither better nor worse. The flowering branches grow naturally, some long, some short.', type: 'authentic'
        },
        {
          text: 'To study the self is to forget the self. To forget the self is to be enlightened by the ten thousand things.', type: 'authentic'
        },
        { text: 'Do not seek to follow in the footsteps of the wise. Seek what they sought.', type: 'authentic' },
        { text: 'When you paint Spring, do not paint willows, plums, peaches, or apricots. Just paint Spring.',
          type: 'authentic' },
        {
          text: 'Have good trust in yourself, not in the one that you think you should be, but in the one that you are.', type: 'authentic'
        },
        # Composed — original, Zen-voiced
        { text: 'Still water holds the sky.', type: 'composed' },
        { text: 'The stone does not ask why it sits.', type: 'composed' },
        { text: 'A single candle does not compete with the sun.', type: 'composed' },
        { text: 'The cup that is full cannot receive.', type: 'composed' },
        { text: 'Wind moves the grass. The root does not argue.', type: 'composed' },
        { text: 'Every step on the path is the path.', type: 'composed' },
        { text: 'A bird does not sing because it has an answer. It sings because it has a song.', type: 'composed' },
        { text: 'The shadow of a bird leaves no trace on the sky.', type: 'composed' },
        { text: 'The thread breaks where it is thinnest. The rope holds where it is braided.', type: 'composed' },
        { text: 'A tree that falls makes more noise than a forest that grows.', type: 'composed' },
        { text: 'The finger pointing at the moon is not the moon.', type: 'composed' },
        { text: 'Sand does not cling to the wave.', type: 'composed' },
        { text: 'The bell rings because it is empty.', type: 'composed' },
        { text: 'Ash does not return to wood.', type: 'composed' },
        { text: 'The river does not drink its own water.', type: 'composed' }
      ],
      'musashi' => [
        # Authentic — verified Go Rin no Sho / Dokkodo
        { text: 'Think lightly of yourself and deeply of the world.', type: 'authentic' },
        { text: 'Do nothing which is of no use.', type: 'authentic' },
        { text: 'Perceive that which cannot be seen with the eye.', type: 'authentic' },
        { text: 'In battle, if you make your opponent flinch, you have already won.', type: 'authentic' },
        { text: 'Do not let the enemy see your spirit.', type: 'authentic' },
        { text: 'The true science of martial arts means practicing them in such a way that they will be useful at any time.',
          type: 'authentic' },
        { text: 'Today is victory over yourself of yesterday.', type: 'authentic' },
        { text: 'Step by step walk the thousand-mile road.', type: 'authentic' },
        { text: 'If you know the way broadly you will see it in everything.', type: 'authentic' },
        { text: 'You can only fight the way you practice.', type: 'authentic' },
        { text: "The important thing in strategy is to suppress the enemy's useful actions.", type: 'authentic' },
        { text: 'From one thing, know ten thousand things.', type: 'authentic' },
        { text: 'Do not sleep under a roof. Carry no money or food.', type: 'authentic' },
        { text: 'Respect Buddha and the gods without counting on their help.', type: 'authentic' },
        { text: 'Never let yourself be saddened by a separation.', type: 'authentic' },
        # Composed — original, Musashi-voiced
        { text: 'A dull blade is worse than no blade. Sharpen it or leave it.', type: 'composed' },
        { text: 'Hesitation is a wound that bleeds before the battle.', type: 'composed' },
        { text: 'Study your enemy until you know him better than he knows himself.', type: 'composed' },
        { text: 'The ground you stand on is yours only while you defend it.', type: 'composed' },
        { text: 'The gap between knowing and doing is where battles are lost.', type: 'composed' },
        { text: 'Strike where the armor gaps. That is the only strike that matters.', type: 'composed' },
        { text: 'The sword has no opinion. The hand that holds it does.', type: 'composed' },
        { text: 'A stance with no opening gives the enemy nothing to read.', type: 'composed' },
        { text: 'Cut once. Step back. See what remains.', type: 'composed' },
        { text: 'The man who grips his sword too tightly cannot feel the blade.', type: 'composed' },
        { text: 'Your footwork tells the enemy more than your eyes do.', type: 'composed' },
        { text: 'A technique you have not tested in fatigue is a technique you do not own.', type: 'composed' },
        { text: 'The second strike exists because the first was not enough.', type: 'composed' },
        { text: 'Do not admire the sword. Admire the thousand hours behind it.', type: 'composed' },
        { text: 'An enemy who is calm is more dangerous than one who is angry.', type: 'composed' }
      ]
    }.freeze

    def self.run(store)
      store.seed(DEFAULT_QUOTES)
    end
  end
end
