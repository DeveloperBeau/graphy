<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForRc5(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc5-trend">
  <TrendSparkline />
  <p>{trendForRc5(rows)}</p>
</div>

<style>
  .rc5-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
