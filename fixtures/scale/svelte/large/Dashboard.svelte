<script>
  import ModernSection from './ModernSection.svelte';
  import ClassicSection from './ClassicSection.svelte';
  import LightweightSection from './LightweightSection.svelte';
  import LegacySection from './LegacySection.svelte';
  import HardwareSection from './HardwareSection.svelte';
  import HistoricSection from './HistoricSection.svelte';
  import StreamSection from './StreamSection.svelte';
  import EstreamSection from './EstreamSection.svelte';

  export let rows = [];

  function refreshMetrics(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="dashboard">
  <ModernSection />
  <ClassicSection />
  <LightweightSection />
  <LegacySection />
  <HardwareSection />
  <HistoricSection />
  <StreamSection />
  <EstreamSection />
  <p>{refreshMetrics(rows)}</p>
</div>

<style>
  .dashboard {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
