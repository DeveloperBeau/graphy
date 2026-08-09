<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForAnubis(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="anubis-trend">
  <TrendSparkline />
  <p>{trendForAnubis(rows)}</p>
</div>

<style>
  .anubis-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
