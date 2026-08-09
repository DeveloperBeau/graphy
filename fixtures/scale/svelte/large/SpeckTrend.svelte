<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSpeck(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="speck-trend">
  <TrendSparkline />
  <p>{trendForSpeck(rows)}</p>
</div>

<style>
  .speck-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
