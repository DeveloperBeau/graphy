<script>
  export let preset = 'plain';

  function ruleCount() {
    return preset === 'build' ? 14 : preset === 'server' ? 9 : 0;
  }
</script>

<span class="rule-counter">{ruleCount()} colour rules active</span>

<style>
  .rule-counter {
    opacity: 0.7;
  }
</style>
