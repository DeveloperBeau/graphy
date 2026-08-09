<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForRc6(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc6-trend">
  <TrendSparkline />
  <p>{trendForRc6(rows)}</p>
</div>

<style>
  .rc6-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
