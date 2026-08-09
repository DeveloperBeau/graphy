<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForRc2(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc2-trend">
  <TrendSparkline />
  <p>{trendForRc2(rows)}</p>
</div>

<style>
  .rc2-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
