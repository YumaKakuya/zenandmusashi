# frozen_string_literal: true

require_relative 'store'

module ZenAndMusashi
  module Seed
    DEFAULT_QUOTES = {
      'zen' => [
        # Authentic
        { text: 'Before enlightenment, chop wood, carry water. After enlightenment, chop wood, carry water.',
          type: 'authentic' },
        { text: 'The obstacle is the path.', type: 'authentic' },
        { text: 'When you reach the top of the mountain, keep climbing.', type: 'authentic' },
        { text: 'The quieter you become, the more you are able to hear.', type: 'authentic' },
        { text: 'One who conquers himself is greater than one who conquers a thousand men in battle.',
          type: 'authentic' },
        { text: 'Let go or be dragged.', type: 'authentic' },
        { text: 'The mind is everything. What you think you become.', type: 'authentic' },
        { text: 'Do not dwell in the past, do not dream of the future, concentrate the mind on the present moment.',
          type: 'authentic' },
        { text: 'No snowflake ever falls in the wrong place.', type: 'authentic' },
        { text: 'The whole moon and the entire sky are reflected in one dewdrop on the grass.', type: 'authentic' },
        { text: 'Sitting quietly, doing nothing, spring comes and the grass grows by itself.', type: 'authentic' },
        { text: 'The way is not in the sky. The way is in the heart.', type: 'authentic' },
        {
          text: 'If you understand, things are just as they are. If you do not understand, things are just as they are.', type: 'authentic'
        },
        { text: 'When the student is ready, the teacher will appear.', type: 'authentic' },
        { text: 'A flower falls, even though we love it; and a weed grows, even though we do not love it.',
          type: 'authentic' },
        # Composed
        { text: 'Still water holds the sky.', type: 'composed' },
        { text: 'The stone does not ask why it sits.', type: 'composed' },
        { text: 'A single candle does not compete with the sun.', type: 'composed' },
        { text: 'The cup that is full cannot receive.', type: 'composed' },
        { text: 'Wind moves the grass. The root does not argue.', type: 'composed' },
        { text: 'Every step on the path is the path.', type: 'composed' },
        { text: 'The mountain does not hurry to the sea.', type: 'composed' },
        { text: 'A bird does not sing because it has an answer. It sings because it has a song.', type: 'composed' },
        { text: 'The shadow of a bird leaves no trace on the sky.', type: 'composed' },
        { text: 'Rain falls on the just and unjust roof alike.', type: 'composed' },
        { text: 'The thread breaks where it is thinnest. The rope holds where it is braided.', type: 'composed' },
        { text: 'A tree that falls makes more noise than a forest that grows.', type: 'composed' },
        { text: 'The finger pointing at the moon is not the moon.', type: 'composed' },
        { text: 'Sand does not cling to the wave.', type: 'composed' },
        { text: 'The bell rings because it is empty.', type: 'composed' }
      ],
      'musashi' => [
        # Authentic (from Go Rin no Sho and related)
        { text: 'Think lightly of yourself and deeply of the world.', type: 'authentic' },
        { text: 'You must understand that there is more than one path to the top of the mountain.', type: 'authentic' },
        { text: 'Do nothing which is of no use.', type: 'authentic' },
        { text: 'Perceive that which cannot be seen with the eye.', type: 'authentic' },
        { text: 'It is difficult to understand the universe if you only study one planet.', type: 'authentic' },
        { text: 'In battle, if you make your opponent flinch, you have already won.', type: 'authentic' },
        { text: 'Do not let the enemy see your spirit.', type: 'authentic' },
        {
          text: 'The true science of martial arts means practicing them in such a way that they will be useful at any time.', type: 'authentic'
        },
        { text: 'Today is victory over yourself of yesterday.', type: 'authentic' },
        { text: 'Step by step walk the thousand-mile road.', type: 'authentic' },
        { text: 'If you know the way broadly you will see it in everything.', type: 'authentic' },
        { text: 'You can only fight the way you practice.', type: 'authentic' },
        { text: "The important thing in strategy is to suppress the enemy's useful actions.", type: 'authentic' },
        { text: 'To win any battle, you must fight as if you are already dead.', type: 'authentic' },
        { text: 'From one thing, know ten thousand things.', type: 'authentic' },
        # Composed
        { text: 'A dull blade is worse than no blade. Sharpen it or leave it.', type: 'composed' },
        { text: 'The warrior who fears death has already died a thousand times.', type: 'composed' },
        { text: 'Hesitation is a wound that bleeds before the battle.', type: 'composed' },
        { text: 'Study your enemy until you know him better than he knows himself.', type: 'composed' },
        { text: 'A plan that survives contact with the enemy was never a plan. It was a prayer.', type: 'composed' },
        { text: 'The ground you stand on is yours only while you defend it.', type: 'composed' },
        { text: 'Victory belongs to the one who wants it less.', type: 'composed' },
        { text: 'Train as you bleed. Bleed as you train.', type: 'composed' },
        { text: 'A castle built on sand commands no loyalty.', type: 'composed' },
        { text: 'The arrow that misses teaches more than the arrow that hits.', type: 'composed' },
        { text: 'He who defends everything defends nothing.', type: 'composed' },
        { text: 'The gap between knowing and doing is where battles are lost.', type: 'composed' },
        { text: 'A general who cannot feed his troops commands only hunger.', type: 'composed' },
        { text: 'Strike where the armor gaps. That is the only strike that matters.', type: 'composed' },
        { text: 'The sword has no opinion. The hand that holds it does.', type: 'composed' }
      ]
    }.freeze

    def self.run(store)
      store.seed(DEFAULT_QUOTES)
    end
  end
end
